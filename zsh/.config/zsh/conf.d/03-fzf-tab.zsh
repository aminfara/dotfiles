(( $+functions[enable-fzf-tab] )) || return 1

# fzf-tab needs zsh's own menu off so it can take over.
zstyle ':completion:*' menu no

# fzf-tab ignores %F{}/%f in group headers, so z1's coloured formats would leak
# raw escapes. Plain text instead; the generic format would shadow these.
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:messages' format '[%d]'
zstyle ':completion:*:warnings' format '[no matches found]'
zstyle ':completion:*:corrections' format '[%d (errors: %e)]'

# fzf-tab already filters fuzzily, and _match/_approximate headers get squashed
# together under group-name ''. Plain completion only.
zstyle ':completion:*' completer _complete

# Leave .. out of path completion; it sorts first and becomes the default pick.
zstyle ':completion:*' special-dirs false

# Tab/Space accept; < and > switch groups.
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept' 'space:accept'
zstyle ':fzf-tab:*' switch-group '<' '>'

# Preview directories with eza and files with bat.
zstyle ':fzf-tab:complete:*' fzf-preview '
  p=${realpath#-*=}
  if [[ -d $p ]]; then
    command eza -1 --color=always --icons --group-directories-first -- $p
  elif [[ -f $p ]]; then
    command bat --color=always --style=numbers --line-range=:200 -- $p
  fi'

# Preview man pages. z1's separate-sections makes the group
# 'manual page, section N (...)', so take the section from there.
zstyle ':fzf-tab:complete:(\\|*/|)man:' fzf-preview '
  [[ $group == "manual page"* ]] || return
  [[ $group == *", section "* ]] && s=${${group#*, section }%% *}
  MANWIDTH=$FZF_PREVIEW_COLUMNS command man $s $word 2>/dev/null |
    command bat --color=always --plain --language=man'

# Preview a parameter's value.
zstyle ':fzf-tab:complete:(-parameter-|-brace-parameter-|export|unset|expand):*' \
  fzf-preview 'echo ${(P)word}'
