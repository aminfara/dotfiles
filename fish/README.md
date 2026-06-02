My Fish setup and configuration files.

Sets up Fish goodies, Homebrew, mise, and more. Stow into `~/.config/fish`.

## First run

```fish
stow fish
fish ~/.config/fish/install.fish   # installs brew tools + fisher + plugins
exec fish
```

## Cool stuff

### Auto-suggestions and syntax highlighting

Fish ships these out of the box — no plugins needed. Type part of a command and
ghost-text suggestions appear from history. Press `→` or `End` to accept.

### ls alternatives

`ls` is aliased to `eza`. Also try `l`, `ll`, `la` (detailed), `lsi` (icons + dirs first).

### cd alternatives

`cd` is backed by [zoxide](https://github.com/ajeetdsouza/zoxide) — it learns
your most-visited directories and jumps there by partial name. `cdi` opens an
interactive picker (`zi`). `..`, `...`, `....` go up multiple directories.
Use `up 3` to go up N levels.

### cat alternatives

`cat` is aliased to `bat` — syntax highlighting, git integration, line numbers.
Use `help <command>` to pipe `--help` output through bat with syntax highlighting.
Press `Ctrl-Alt-H` to wrap the current command line in `help` and run it (Ghostty only).

### man alternatives

Man pages are rendered through `bat` automatically via `MANPAGER`.

### ps / top alternatives

`top` → `btop -p 0` (overview), `psi` → `btop -p 1` (process list).

### grep alternatives

Use `rg` (ripgrep) — faster, smarter, respects `.gitignore` by default.

### fzf integration

Powered by [fzf.fish](https://github.com/PatrickF1/fzf.fish) (requires Ghostty or kitty for Ctrl-Alt-* bindings):

| Key | Action |
|---|---|
| `Ctrl-R` | Search command history |
| `Ctrl-Alt-F` | Search directory (files + dirs) |
| `Ctrl-Alt-L` | Search git log |
| `Ctrl-Alt-S` | Search git status |
| `Ctrl-Alt-P` | Search processes |

> Note: `Ctrl-Alt-*` bindings require a terminal that forwards them (Ghostty ✓, kitty ✓). VSCode and Zed terminals intercept these keys.

### git abbreviations

61 git abbreviations — type the short form and fish expands it inline before
running so history records the full command. Try `gst`, `glo`, `glog`, `gd`, `gp`.

Run `abbr --show | grep git` to see the full list.

Also use `lg` for [lazygit](https://github.com/jesseduffield/lazygit) — a terminal UI for git.

### Starship prompt

Powered by [Starship](https://starship.rs/) — minimal, fast, git-aware, language-aware.
Expands automatically when inside a git repo or a project with language tooling.

### mise integration

[mise](https://mise.jdx.dev/) manages language runtimes (Node, Python, Go, Java, etc.)
and auto-switches versions when you `cd` into a project with a `.mise.toml` or `.tool-versions`.

### Notifications

[done](https://github.com/franciscolourenco/done) sends a desktop notification
when a long-running command finishes. Works on macOS and Linux.

## Useful functions

| Function | Description |
|---|---|
| `n [path]` | Open nvim (`.` if no args) |
| `up [N]` | Go N directories up (default 1) |
| `mkcd <dir>` | `mkdir -p` then `cd` into it |
| `extract <file>` | Extract any archive format |
| `backup <file>` | Copy `file` to `file.bak` |
| `help <cmd>` | Render `--help` output through bat |
| `install-cli-tools` | Idempotent brew install/upgrade of tracked tools |

## Plugins

Managed by [fisher](https://github.com/jorgebucaran/fisher). See `fish_plugins` for the full list.

| Plugin | Purpose |
|---|---|
| `PatrickF1/fzf.fish` | fzf key bindings |
| `jorgebucaran/autopair.fish` | Auto-close brackets and quotes |
| `meaningful-ooo/sponge` | Remove failed commands from history |
| `franciscolourenco/done` | Desktop notifications for long commands |

## Other stuff

See `conf.d/50-abbr.fish` for all aliases and abbreviations, and
`functions/install-cli-tools.fish` to add/remove tracked brew packages.
