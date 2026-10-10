#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  $HOME/.local/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /home/linuxbrew/.linuxbrew/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Homebrew's completions. z1 runs `brew shellenv`, but that prints nothing when
# PATH already starts with the Homebrew bin dirs, as it does here.
fpath=(
  /opt/homebrew/share/zsh/site-functions(N-/)
  /home/linuxbrew/.linuxbrew/share/zsh/site-functions(N-/)
  $fpath
)
