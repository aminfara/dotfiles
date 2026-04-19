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

## Agent file-ownership convention

The agents follow a simple, consistent rule for cross-agent file access:

> **Read freely. Write only your own domain.**

Every agent has one (sometimes more) folder or file that it **owns**. Any agent
may **read** any file in the project — that's how downstream agents pick up
upstream work. But **only the owner** may **write** to its domain.

| Owner | Domain (write) | Notes |
|---|---|---|
| **Olie** | `AGENTS.md` (project memory) | The shared, opinionated description of the project. Other agents propose updates via a `## Memory Update` section in their reports; Olie applies them. |
| **Percy** | `requirements/` | Product backlog, requirement files, user journeys, wireframes. |
| **Archie** | `architecture/` | Architecture docs, ADRs, API specs, data schemas, diagrams. |
| **Becky** | Backend / shared / infrastructure source code | The actual production code on the server side. |
| **Frankie** | Frontend / mobile source code | UI components, frontend state, API clients. |
| **Quincy** | (none — read-only reviewer) | Produces review reports inline; never edits source. |
| **Tessie** | Acceptance-test artefacts (e.g. `tests/acceptance/`) | Blackbox tests written from the user's perspective. |
| **Otis** | Anything inside the diff window it was scoped to | Pure structural improvements, no behaviour changes. |
| **Toby** | `SERVICE_STATUS.md` + IaC / pipeline / deploy configs | The operational source of truth + the things that actually deploy. |
| **Richie** | `research/<topic>/` folders | Self-contained research outputs: `REPORT.md`, supporting data (Parquet + CSV), figures, scripts, sources, logs. |
| **Severus** | (none — opaque scheduler) | Stateless dispatcher; the MCP holds all state. |

### Reading the work of other agents

- Anyone may `read` any tracked file. Use this freely — it's how chains like
  *Richie → Percy* (research → requirements) and *Archie → Becky* (design →
  implementation) work.
- The owning agent is responsible for making its outputs **discoverable from a
  single entry point** (e.g. Richie's `REPORT.md` references every supporting
  file by relative path, so a reader who opens only `REPORT.md` can find
  everything else).

### Writing outside your domain

- Don't. If you find yourself wanting to, route the change through the owner
  (or, for orchestrated work, through Olie).
- The two exceptions baked into agent contracts:
  - **Olie** may add a `## Memory Update` section to AGENTS.md based on other
    agents' suggestions — but only Olie writes that file.
  - **Toby** may surgically hotfix application code during a live incident —
    but the diff is captured and committed back through Becky / Frankie within
    the hour.
