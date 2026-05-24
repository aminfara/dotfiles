#!/usr/bin/env python3

import json
import subprocess
import sys


def hyprctl_json(*args: str):
    output = subprocess.check_output(["hyprctl", *args], text=True)
    return json.loads(output)


def hyprctl_dispatch(*args: str) -> None:
    subprocess.run(["hyprctl", "dispatch", *args], check=False)


def main() -> int:
    direction = sys.argv[1] if len(sys.argv) > 1 else "next"
    if direction not in {"next", "prev"}:
        return 2

    active = hyprctl_json("activewindow", "-j")
    clients = hyprctl_json("clients", "-j")

    active_address = active.get("address")
    active_class = active.get("class")
    active_workspace = active.get("workspace", {}).get("id")

    if not active_address or not active_class or active_workspace is None:
        return 0

    matches = []
    for client in clients:
        if client.get("class") != active_class:
            continue

        workspace_id = client.get("workspace", {}).get("id")
        if workspace_id != active_workspace and not client.get("pinned", False):
            continue

        address = client.get("address")
        if address:
            matches.append(address)

    if len(matches) < 2:
        return 0

    try:
        index = matches.index(active_address)
    except ValueError:
        index = 0

    step = -1 if direction == "prev" else 1
    target = matches[(index + step) % len(matches)]

    if target == active_address:
        return 0

    hyprctl_dispatch("focuswindow", f"address:{target}")
    hyprctl_dispatch("bringactivetotop")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())