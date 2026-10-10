# Overrides to z1's defaults.

# One history across terminals. share_history appends on its own, and the zsh
# manual says to turn inc_append_history off alongside it.
setopt share_history
unsetopt inc_append_history

# Magic Enter: an empty line runs ls, or git status inside a repo.
zstyle ':z1:editor:default-command' command 'ls'
zstyle ':z1:editor:default-command' git-command 'git status -sb'

# How Up/Down history search paints the match.
zstyle ':z1:editor' search-highlight 'bg=blue,fg=black,bold'

# Suggest from history first, fall back to completion when history diverges.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Clear the ghost suggestion when z1's Up/Down search swaps the line.
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(up-line-or-history-search down-line-or-history-search)

# Ghostty on macOS sends Alt-Left/Right as Esc-b/Esc-f, not the sequences z1
# binds. Walk directory history on an empty line, move by word otherwise.
if (( $+widgets[prevd-or-backward-word] )); then
  bindkey '^[b' prevd-or-backward-word
  bindkey '^[f' nextd-or-forward-word
fi

# z1 binds copybuffer to Ctrl-X Ctrl-C, but the terminal turns Ctrl-C into an
# interrupt before zle sees it. Ctrl-O instead, as Oh My Zsh does.
bindkey -M emacs '^O' copybuffer
bindkey -M viins '^O' copybuffer
