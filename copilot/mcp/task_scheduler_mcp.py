#!/usr/bin/env python3
"""
Task Scheduler MCP Server
=========================
Provides the `request_next_task` tool for Severus Scheduler.

- Reads TODO from the root path provided by the client.
- Marks the first non-~ task with `~ ` (in-progress / now being processed).
- Moves previously `~ `-marked tasks to DONE (they are assumed complete
  because the tool was called again, meaning the last task is done).
- Returns the task text, or `~` when there are no more pending tasks.

The list is intentionally DYNAMIC — new tasks may appear in TODO at any
time.  The tool therefore never caches state; it always reads fresh from disk.

Note: TODO and DONE are plain text files, not Markdown. No `.md` extension.
"""

import json
import sys
import os
import re
from datetime import datetime


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


def request_next_task(root_path: str) -> str:
    """
    Core logic for the request_next_task MCP tool.

    1. Open TODO from root_path.
    2. Collect every line that starts with `~ ` → these are tasks that were
       in-progress during the *previous* call and are now considered DONE.
       Move them to DONE.
    3. Find the first line that does NOT start with `~ ` and is not blank /
       a heading / a comment — that is the next task.
    4. Mark it with `~ ` in TODO and return its text.
    5. If no pending task is found, return `~`.
    """
    todo_path = os.path.join(root_path, "TODO")
    done_path = os.path.join(root_path, "DONE")

    lines = read_lines(todo_path)

    # ------------------------------------------------------------------ #
    # Step 1 – harvest previously in-progress lines and move them to DONE  #
    # ------------------------------------------------------------------ #
    in_progress: list[str] = []
    remaining: list[str] = []

    for line in lines:
        if line.startswith("~ "):
            # Strip the marker so DONE.md holds clean task text
            clean = line[2:].rstrip("\n")
            in_progress.append(clean)
        else:
            remaining.append(line)

    if in_progress:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        done_block: list[str] = []
        for task in in_progress:
            # Plain text format — TODO and DONE are not markdown files.
            done_block.append(f"[{timestamp}] {task}\n")
        append_lines(done_path, done_block)

    # ------------------------------------------------------------------ #
    # Step 2 – find the next pending task                                 #
    # A pending task is any non-blank line that:                          #
    #   • does NOT start with `~ `  (not in-progress / done)             #
    #   • does NOT start with `#`   (treated as a comment line)          #
    # ------------------------------------------------------------------ #
    next_task_index: int = -1
    next_task_text: str = ""

    for i, line in enumerate(remaining):
        stripped = line.strip()
        if not stripped:
            continue
        if stripped.startswith("#"):
            continue
        # This is a pending task
        next_task_index = i
        next_task_text = stripped
        break

    # ------------------------------------------------------------------ #
    # Step 3 – mark the chosen task as in-progress and save TODO         #
    # ------------------------------------------------------------------ #
    if next_task_index == -1:
        # No pending tasks — but list is DYNAMIC, so we just signal ~
        write_lines(todo_path, remaining)
        return "~"

    # Prepend `~ ` to mark as in-progress
    remaining[next_task_index] = "~ " + remaining[next_task_index].lstrip()
    write_lines(todo_path, remaining)

    # Strip leading list markers (-, *) if present, for a clean prompt
    clean_task = re.sub(r"^[-*]\s+", "", next_task_text).strip()

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
