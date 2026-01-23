alias c="clear"

alias path="tr ':' '\\n' <<< \$PATH"
alias fpath="tr ':' '\\n' <<< \$FPATH"

if (( $+commands[btop] )); then
  alias top="btop -p 0"
  alias psi="btop -p 1"
fi

if (( $+commands[eza] )); then
  compdef _eza ls
  alias ls="eza"
  alias lsi="eza --group-directories-first --icons"
  alias ll="lsi -l"
  alias la="lsi -al"
  alias l="lsi -aal"
fi

if (( $+commands[bat] )); then
  alias cat="bat --paging=never --style=plain"
  alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi

if (( $+functions[z] )); then
  alias cd="z"
  alias cdi="zi"
fi
