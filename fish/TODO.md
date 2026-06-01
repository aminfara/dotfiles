# Fish config — TODO

Pick-up list for future sessions. Items roughly grouped by theme; not strictly
ordered.

## Done so far

- Cross-OS PATH bootstrap (`00-path.fish`) — user > brew > /usr/local, brew shellenv
- Baseline env (`01-env.fish`) — XDG, locale, EDITOR/VISUAL/GIT_EDITOR
- Tools wired (`10-tools.fish`) — starship, zoxide
- Aliases (`50-abbr.fish`) — `cd→z`, `cdi→zi`, eza family (`ls`, `lsi`, `ll`, `la`, `l`)
- fisher + plugins (`fish_plugins`, `install.fish`) — PatrickF1/fzf.fish
- Tool installer (`functions/install-cli-tools.fish`) — idempotent brew install/upgrade with macOS/Linux extras
- `.gitignore` allowlist so fisher-installed files don't leak into git

## Plugins to evaluate

- [ ] **jorgebucaran/autopair.fish** — auto-close brackets, quotes, parens.
- [ ] **meaningful-ooo/sponge** — drop failed commands from history so autosuggest stays clean.
- [ ] **gazorby/fish-abbreviation-tips** — nags you when you type a long form that has an abbr. Possibly naggy; trial briefly.
- [ ] **edc/bass** — only if/when we hit a bash-only script we need to source.

Decision criteria: each plugin must be small, popular, well-maintained, and earn its slot. No bundled plugin packs.

## Tools to wire in `10-tools.fish`

- [ ] **mise** — `command -q mise; and mise activate fish | source`
- [ ] **bat** — `BAT_THEME`, `MANPAGER`, `PAGER` exports (mirror zsh `06-bat.zsh`)
- [ ] **eza** — `EZA_CONFIG_DIR` (only if we ship a theme dir)
- [ ] **lazygit** — `lg` alias (mirror zsh `08-lazygit.zsh`)
- [ ] **fzf customisations** — revisit `fzf_preview_dir_cmd` (eza) and `fzf_diff_highlighter` (delta). Reverted last session because:
    - eza `--icons=always` emits correct bytes but glyphs didn't render in fzf preview pane (font/width issue, not config)
    - delta `--side-by-side=false` is invalid; correct override is `--features=-side-by-side` plus `--width=20`
    - Want to re-test on a font-correct setup before re-enabling

## Abbreviations / aliases to add (`50-abbr.fish`)

Inspired by zsh `50-aliases.zsh` and Omarchy/popular fish configs.

- [ ] `c` → `clear`
- [ ] `path` → print PATH one-per-line: `string split : -- $PATH`
- [ ] `top` → `btop -p 0`, `psi` → `btop -p 1` (when `btop` present)
- [ ] `cat` → `bat --paging=never --style=plain` (when `bat` present)
- [ ] Git family — `g`, `gst`, `ga`, `gcm`, `gcam`, `gp`, `gd`, `gl` (consider abbr vs alias for each)
- [ ] `..`, `...`, `....` for parent navigation (or use puffer-fish plugin)
- [ ] `up` function that goes n level up dir or hit root
- [ ] `n` function — `nvim .` if no args else `nvim $argv`
- [ ] `mkcd` function — `mkdir -p $argv && cd $argv`
- [ ] `open` function on Linux — `xdg-open $argv >/dev/null 2>&1 &` (gated on `uname` and presence of `xdg-open`)

Style preference: `alias` when history should show the original command (e.g. `cd→z`); `abbr` when learning aid matters and inline expansion is welcome.

## Keybindings (new `conf.d/60-keybinds.fish`)

- [ ] History substring search on Up/Down arrows (zsh has `01-history-sub-search.zsh`)
    - Fish has `up-or-search` by default — confirm whether anything more is needed
- [ ] Any custom widgets that wrap fzf.fish without conflicting

## Prompt

- [ ] Decide: share single `~/.config/starship.toml` with zsh, or ship a fish-specific one?
- [ ] If sharing: drop `STARSHIP_CONFIG` override from zsh and move toml to standard location.

## Installer (`functions/install-cli-tools.fish`)

- [ ] Add per-package status output (`[ok]`/`[install]`/`[upgrade]`) — currently relies on raw brew output.
- [ ] Optional `--dry-run` flag.
- [ ] Linux-specific extras still empty — add when we identify real needs.
- [ ] Consider reading shared formula list from the workspace `Brewfile` instead of duplicating.

## Cross-shell parity & hygiene

- [ ] `fish/README.md` mirroring `zsh/README.md` (what's cool, how to use).
- [ ] Decide whether `XDG_*`, `LANG`, `EDITOR` should be shared via a single login-shell agnostic file (e.g. sourced by both zsh `.zshenv` and fish `01-env.fish`).
- [ ] Profile startup time as a real login shell (current ~280ms is inflated by parent-zsh PATH inheritance).

## Known issues to revisit

- [ ] **Zed embedded terminal** swallows `Ctrl-Alt-*` so fzf.fish's git log / git status / processes / directory pickers don't work there. Documented in `10-tools.fish`. Real fix is upstream (Zed); workaround would be rebinding to plain `Ctrl-*` keys at the cost of overriding fish defaults — declined.
- [ ] **fzf preview pane font rendering** — `--icons=always` bytes are correct but glyphs didn't appear. Likely Nerd Font / pane-width issue; verify font installed and try larger preview widths.
