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

if (( $+functions[z] )); then
  alias cd="z"
  alias cdi="zi"
fi
