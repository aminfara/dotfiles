# Ayu colours for ls/eza, completion and fzf-tab previews, matching Ghostty.
(( $+commands[vivid] )) || return 1

export LS_COLORS="$(vivid generate ayu)"

# z1 set list-colors from the old LS_COLORS while loading.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
