# Ctrl-Alt-H: toggle `help` on the current command line.
#   - line starts with `help `  → strip the prefix
#   - line has other text       → run `help <text>`
#   - empty line after `help X` → put `X` back on the line
function help-toggle() {
  local cmd=${${BUFFER##[[:space:]]#}%%[[:space:]]#}

  if [[ -z $cmd ]]; then
    local last=${history[$((HISTCMD - 1))]}
    if [[ $last == help\ ?* ]]; then
      BUFFER=${last#help }
      CURSOR=$#BUFFER
    fi
  elif [[ $cmd == help\ ?* ]]; then
    BUFFER=${cmd#help }
    CURSOR=$#BUFFER
  else
    BUFFER="help $cmd"
    zle accept-line
  fi
}
zle -N help-toggle
bindkey -M emacs '^[^H' help-toggle
bindkey -M viins '^[^H' help-toggle

# macOS: Option types special characters instead of acting as Alt, so bind the
# characters Option-c and Option-s produce to their Alt widgets.
if is-macos; then
  (( $+widgets[fzf-cd-widget] )) && bindkey 'ç' fzf-cd-widget  # Option-c: fzf cd
  bindkey 'ß' prepend-sudo                                       # Option-s: prepend sudo
fi
