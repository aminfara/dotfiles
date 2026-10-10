#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Load zstyles first: antidote reads them while bundling, z1 while loading.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles
zstyle ':z1:zstyles' loaded yes

# Homebrew completions (_mise, _eza, ...) must be on fpath before compinit.
# z1's `brew shellenv` adds them only when PATH does not already start with the
# Homebrew bin dirs, which depends on the parent process, so add them here.
fpath=(/opt/homebrew/share/zsh/site-functions(N-/) $fpath)

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Load plugins. z1 comes first and autoloads functions/ on its way in.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# z1 re-adds its search-highlight hooks here to run after any highlighter.
# fast-syntax-highlighting has already wrapped zle-line-finish around them, so
# re-adding makes the two call each other until FUNCNEST. Its hooks already run
# after the highlighter without it.
post_zshrc_hook=(${post_zshrc_hook:#history-search-highlight-last})

# z1 defers conf.d to the first prompt; run it now so starship draws that prompt.
run_post_zshrc

if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
