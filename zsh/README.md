My ZSH setup and configuration files.

Built on [z1](https://github.com/mattmc3/z1) for sane Zsh defaults and [antidote](https://antidote.sh) for plugins. Stow into `~/.config/zsh` with `stow zsh`.

## Layout

- `.zsh_plugins.txt`: antidote plugin list. z1 loads first.
- `.zstyles`: settings for antidote, z1 and plugins.
- `conf.d/`: per-tool setup, sourced in name order.
- `functions/`: autoloaded functions.

Machine-specific settings go in `~/.zshrc.local`.

## Cool stuff

### auto-suggestions and syntax highlighting

Type part of a command and ghost text suggests the rest from history, falling back to completion. Press `→` to accept.

### history search

Type part of a command and press `↑`/`↓` to walk matching history entries. Matches by substring, not only prefix.

### keys

| Key | Action |
|---|---|
| `Enter` on an empty line | Run `ls`, or `git status -sb` inside a repo |
| `Alt-←` / `Alt-→` on an empty line | Go to the previous/next directory (moves by word when the line has text) |
| `Alt-s` | Prepend `sudo` |
| `Ctrl-X Ctrl-E` | Edit the command line in `$EDITOR` |
| `Ctrl-O` | Copy the command line to the clipboard |
| `Ctrl-Z` | Resume the last suspended job |
| `Ctrl-Alt-H` | Toggle `help` on the command line |

### help

`help <command>` renders `<command> --help` through `bat`, or opens the man page for commands without `--help` (BSD `ls`, `cp`, `man`). Press `Ctrl-Alt-H` to wrap the current command line in `help` and run it; press it again on the empty line to get the command back.

### ls alternatives

`ls` is aliased to `eza`. Also try `l`, `ll`, `la` (detailed) and `lsi` (icons, directories first).

### cd alternatives

`cd` is [zoxide](https://github.com/ajeetdsouza/zoxide): it learns your most-visited directories and jumps there by partial name. `cdi` opens an interactive picker.

`-` goes back to the previous directory, `dirh` lists directory history, and `..`, `...`, `....` go up.

Use `yazi` to navigate and file operations with a terminal UI.

### cat alternatives

`cat` is aliased to `bat`. Man pages render through `bat` too.

### ps alternatives

Try `psi` and `top` for `btop`.

### grep alternatives

Use `rg` (ripgrep) instead of `grep` for a faster and more feature-rich searching experience.

### fzf integration

`Tab` completion opens an fzf picker ([fzf-tab](https://github.com/Aloxaf/fzf-tab)) with previews: `eza` for directories, `bat` for files, man pages and variable values. `<` and `>` switch groups.

`Ctrl-T` fuzzy finds files, `Ctrl-R` searches history and `Alt-C` (`Option-c`) changes directory.

### git aliases

Try `alias | rg git` to see the git aliases from Oh My Zsh's git plugin. Use `lg` for `lazygit`.

### colours

`LS_COLORS` comes from [vivid](https://github.com/sharkdp/vivid)'s `ayu` theme and `bat` uses the terminal palette, to match Ghostty's Ayu Mirage.

### starship prompt

The prompt is powered by [Starship](https://starship.rs/), configured in `starship.toml`.

### mise integration

The shell is integrated with [mise](https://mise.jdx.dev/) for managing your languages and development environments.

### Homebrew

Tools are listed in the `homebrew` package's Brewfile (`~/.config/homebrew/Brewfile`). `bruc` updates Homebrew, installs or upgrades everything in the Brewfile, then cleans up.

On macOS, `setup-macos-keyboard` sets a fast key repeat.

## Other stuff

Look at `conf.d/50-aliases.zsh` for other aliases.
