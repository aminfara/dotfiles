alias c="clear"

alias path="tr ':' '\\n' <<< \$PATH"
alias fpath="tr ':' '\\n' <<< \$FPATH"

if (( $+commands[btop] )); then
  alias top="btop -p 0"
  alias psb="btop -p 1"
fi

if (( $+commands[eza] )); then
  alias ls="eza --group-directories-first --icons"
  alias l="ll -aa"
fi
