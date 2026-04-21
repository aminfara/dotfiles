#!/usr/bin/env python3
"""
Task Scheduler MCP Server
=========================
Provides the `request_next_task` tool for Severus Scheduler.

- Reads `process/TODO` from the root path provided by the client.
- Marks the first non-~ task with `~ ` (in-progress / now being processed).
- Moves previously `~ `-marked tasks to `process/DONE` (they are assumed complete
  because the tool was called again, meaning the last task is done).
- Returns the task text, or `~` when there are no more pending tasks.

The list is intentionally DYNAMIC — new tasks may appear in TODO at any
time.  The tool therefore never caches state; it always reads fresh from disk.

Note: TODO and DONE are plain text files (no `.md` extension), located
under `process/` next to the per-task tracking files Severus maintains.
"""

import json
import os
import re
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Optional


# ---------------------------------------------------------------------------- #
#  Configuration                                                                #
# ---------------------------------------------------------------------------- #

#: Number of seconds to wait before re-reading TODO when the first read came up
#: empty. Producers may add a task during this window; the retry catches it.
POLITE_LOOK_SECONDS: int = 3 * 60

#: Number of additional read attempts after the first one returns empty.
#: 1 = read, sleep POLITE_LOOK_SECONDS, read once more, then give up.
DEFAULT_RETRIES: int = 1

#: Sentinel returned when the task list is genuinely empty.
EMPTY_SENTINEL: str = "~"

#: Prefix used in the TODO file to mark a task as in-progress.
IN_PROGRESS_PREFIX: str = "~ "

#: Subdirectory (relative to the root path) where TODO and DONE live alongside
#: the per-task tracking files. The directory is created on demand.
PROCESS_DIR: str = "process"

#: Special task token. When the next pending TODO line is exactly this single
#: character, the tool returns RECONCILE_PROMPT instead of the literal token.
#: This lets the queue producer schedule a "reconcile in-flight work" sweep
#: as a normal task, without leaking the prompt text into the TODO file.
RECONCILE_TOKEN: str = "+"

#: Prompt returned when the next pending task is RECONCILE_TOKEN. Instructs
#: the consumer to harvest unfinished `process/*.tmp.md` files and re-queue
#: them at the top of TODO, verbatim.
RECONCILE_PROMPT: str = (
    "list process/*.tmp.md files and search all the ones that are not "
    "completed. For those, add them verbatim at the beginning of the TODO "
    "file. Remove the timestamp at the beginning. Use tools to copy verbatim "
    "instead of just writing it yourself. Preserve the rest of the TODO file "
    "untouched."
)


# ---------------------------------------------------------------------------- #
#  File helpers                                                                 #
# ---------------------------------------------------------------------------- #

def read_lines(path: str) -> list[str]:
    """Read a file and return its lines, or [] if it doesn't exist."""
    if not os.path.exists(path):
        return []
    with open(path, "r", encoding="utf-8") as f:
        return f.readlines()


def write_lines(path: str, lines: list[str]) -> None:
    with open(path, "w", encoding="utf-8") as f:
        f.writelines(lines)


def append_lines(path: str, lines: list[str]) -> None:
    with open(path, "a", encoding="utf-8") as f:
        f.writelines(lines)


def request_next_task(root_path: str, retries: int = DEFAULT_RETRIES) -> str:
    """
    Core logic for the request_next_task MCP tool.

    1. Open `process/TODO` from root_path (creating `process/` if needed).
    2. Collect every line that starts with `~ ` -> these are tasks that were
       in-progress during the *previous* call and are now considered DONE.
       Move them to DONE.
    3. Find the first line that does NOT start with `~ ` and is not blank /
       a heading / a comment - that is the next task.
    4. Mark it with `~ ` in TODO and return its text.
    5. If no pending task is found AND we still have retries left, sleep for
       a "polite second look" window and try again. The list is DYNAMIC so
       producers may drop a task in during that window.
    6. If no pending task is found and no retries remain, return `~`.

    `retries` is the number of *additional* attempts to make after the first
    one comes up empty. Default 1 = at most one polite re-read before
    surrendering with `~`.
    """
    process_dir = os.path.join(root_path, PROCESS_DIR)
    todo_path = os.path.join(process_dir, "TODO")
    done_path = os.path.join(process_dir, "DONE")
    # Ensure process/ exists before any write; harmless if it already does.
    os.makedirs(process_dir, exist_ok=True)
    polite_look_seconds = POLITE_LOOK_SECONDS

    attempts_left = retries + 1  # initial attempt + N retries

    while attempts_left > 0:
        attempts_left -= 1
        lines = read_lines(todo_path)

        # Step 1 - harvest previously in-progress lines and move them to DONE.
        # On retries this is a no-op (we already cleared them on attempt 1).
        in_progress: list[str] = []
        remaining: list[str] = []
        for line in lines:
            if line.startswith(IN_PROGRESS_PREFIX):
                in_progress.append(line[len(IN_PROGRESS_PREFIX):].rstrip("\n"))
            else:
                remaining.append(line)

        if in_progress:
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            append_lines(done_path, [f"[{timestamp}] {task}\n" for task in in_progress])

        # Step 2 - find the next pending task.
        next_task_index: int = -1
        next_task_text: str = ""
        for i, line in enumerate(remaining):
            stripped = line.strip()
            if not stripped or stripped.startswith("#"):
                continue
            next_task_index = i
            next_task_text = stripped
            break

        # Step 3 - mark and return if found.
        if next_task_index != -1:
            remaining[next_task_index] = IN_PROGRESS_PREFIX + remaining[next_task_index].lstrip()
            write_lines(todo_path, remaining)
            break  # exit loop with next_task_text set; trailing block returns it

        # Nothing found this attempt. Save the cleaned TODO.
        write_lines(todo_path, remaining)

        # If more attempts remain, sleep before the next try.
        if attempts_left > 0:
            time.sleep(polite_look_seconds)
        else:
            return EMPTY_SENTINEL

    # Strip leading list markers (-, *) if present, for a clean prompt
    clean_task = re.sub(r"^[-*]\s+", "", next_task_text).strip()

    # Special case: if the queued task is just `+`, expand it to the
    # reconcile prompt so the caller knows what to do. The TODO line itself
    # has already been marked `~ +` (in-progress) and will be moved to DONE
    # on the next call, exactly like any other task.
    if clean_task == RECONCILE_TOKEN:
        return RECONCILE_PROMPT

    return clean_task


# ======================================================================= #
#  MCP stdio JSON-RPC transport                                            #
# ======================================================================= #

def send(obj: dict) -> None:
    sys.stdout.write(json.dumps(obj) + "\n")
    sys.stdout.flush()


def handle_initialize(msg: dict) -> None:
    send({
        "jsonrpc": "2.0",
        "id": msg.get("id"),
        "result": {
            "protocolVersion": "2024-11-05",
            "capabilities": {"tools": {}},
            "serverInfo": {
                "name": "task-scheduler",
                "version": "1.0.0"
            }
        }
    })


def handle_tools_list(msg: dict) -> None:
    send({
        "jsonrpc": "2.0",
        "id": msg.get("id"),
        "result": {
            "tools": [
                {
                    "name": "request_next_task",
                    "description": (
                        "Returns the next pending task as a plain string. Each call also "
                        "implicitly marks the previously returned task as complete. "
                        "The task list is DYNAMIC and may change between calls; callers must "
                        "keep polling. Returns the literal string `~` when no task is "
                        "currently available — this is a transient state, not a terminal one."
                    ),
                    "inputSchema": {
                        "type": "object",
                        "properties": {
                            "root_path": {
                                "type": "string",
                                "description": (
                                    "Absolute path to the project root for which tasks should "
                                    "be scheduled. Treat this as an opaque identifier — it is "
                                    "passed through to the scheduler's internal storage."
                                )
                            }
                        },
                        "required": ["root_path"]
                    }
                }
            ]
        }
    })


def handle_tools_call(msg: dict) -> None:
    params = msg.get("params", {})
    tool_name = params.get("name", "")
    arguments = params.get("arguments", {})

    if tool_name != "request_next_task":
        send({
            "jsonrpc": "2.0",
            "id": msg.get("id"),
            "error": {
                "code": -32601,
                "message": f"Unknown tool: {tool_name}"
            }
        })
        return

    root_path = arguments.get("root_path", "").strip()
    if not root_path:
        send({
            "jsonrpc": "2.0",
            "id": msg.get("id"),
            "error": {
                "code": -32602,
                "message": "Missing required argument: root_path"
            }
        })
        return

    try:
        result = request_next_task(root_path)
        send({
            "jsonrpc": "2.0",
            "id": msg.get("id"),
            "result": {
                "content": [
                    {
                        "type": "text",
                        "text": result
                    }
                ]
            }
        })
    except Exception as exc:  # noqa: BLE001
        send({
            "jsonrpc": "2.0",
            "id": msg.get("id"),
            "error": {
                "code": -32603,
                "message": f"Internal error: {exc}"
            }
        })


HANDLERS = {
    "initialize": handle_initialize,
    "notifications/initialized": lambda _: None,  # no-op
    "tools/list": handle_tools_list,
    "tools/call": handle_tools_call,
}


def main() -> None:
    for raw_line in sys.stdin:
        raw_line = raw_line.strip()
        if not raw_line:
            continue
        try:
            msg = json.loads(raw_line)
        except json.JSONDecodeError:
            continue

        method = msg.get("method", "")
        handler = HANDLERS.get(method)
        if handler:
            handler(msg)
        else:
            # Unknown method — send error only if it has an id (i.e. not a notification)
            if "id" in msg:
                send({
                    "jsonrpc": "2.0",
                    "id": msg["id"],
                    "error": {
                        "code": -32601,
                        "message": f"Method not found: {method}"
                    }
                })


if __name__ == "__main__":
    main()
