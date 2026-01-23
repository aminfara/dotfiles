My ZSH setup and configuration files.

Sets up ZSH goodies, brew, misenplace, and more.

Based on Antidote example at https://github.com/getantidote/zdotdir/tree/main

## Cool stuff

### auto-suggestions and syntax highlighting

The shell comes with auto-suggestions and syntax highlighting out of the box for a better command line experience. Type a part of a command and see suggestions based on your history (up/down arrows to navigate).

### ls alternatives

`ls` is aliased to `eza` for a better directory listing experience. Also try `l`, `ll`, and `la` for a more detailed listing.

### cd alternatives

`cd` is aliased to `z` (zoxide or z) for smarter directory changing. Also try `cdi` for interactive directory changing with `zi`.

You can also use `-` to go back to the previous directory. `..` and `...` are also aliased to go up multiple directories.

Use `yazi` to navigate and file operations with a terminal UI.

### cat alternatives

Use `bat` instead of `cat` for a better file viewing experience with syntax highlighting and git integration.

### ps alternatives

try `psi` and `top` for better process viewing experience

### grep alternatives

Use `rg` (ripgrep) instead of `grep` for a faster and more feature-rich searching experience.

### fzf integration

Try `ctrl-t` to fuzzy find files and `ctrl-r` to fuzzy find commands from history. And `alt-c` to fuzzy find and change directories.

### git aliases

try `alias | rg git` to see all git related aliases.

Also use `lazygit` for a terminal UI for git commands.

### starship prompt

The prompt is powered by [Starship](https://starship.rs/), a minimal, blazing-fast, and infinitely customizable prompt for any shell.

### mise integration

The shell is integrated with [mise](https://https://mise.jdx.dev/) for managing your languages and development environments.

## Other stuff

Look at `.zshrc.d/50-aliases.zsh` and `.zfunctions/install-cli-tools` for other aliases and tools installed.
