# Copilot dotfiles

## Required MCPs

The list of required MCP servers lives in **`mcp-config-*.json`**. Two
versions are provided because Copilot CLI and VS Code use different
schemas:

| Host                  | File                            | Top-level key | Per-entry `type` field |
|-----------------------|---------------------------------|---------------|------------------------|
| Copilot CLI           | `mcp-config-copilotcli.json`    | `mcpServers`  | not used (inferred)    |
| VS Code Copilot Chat  | `mcp-config-vscode.json`        | `servers`     | required (`stdio`/`http`/`sse`) |

Symlink (or copy) whichever you use into the host's expected location:

```sh
# Copilot CLI
ln -sf "$PWD/mcp-config-copilotcli.json" ~/.config/copilot/mcp-config.json

# VS Code (workspace-level)
ln -sf "$PWD/mcp-config-vscode.json" /path/to/workspace/.vscode/mcp.json
```

## Local MCP servers

Custom MCP servers live in `mcp/`. Currently:

- **`mcp/task_scheduler_mcp.py`** — task scheduler used by the Severus
  agent. Reads `TODO` and writes `DONE` (plain text, no extension) in a
  project root path supplied by the caller.

## Skills

Run `npx skills update` to install skills into the `skills/` directory.
