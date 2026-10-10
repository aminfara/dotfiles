alias c="clear"

alias path="tr ':' '\\n' <<< \$PATH"
alias fpath="tr ':' '\\n' <<< \$FPATH"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# z1 aliases help to run-help; functions/help replaces it.
unalias help 2>/dev/null

if (( $+commands[brew] )); then
  # Brewfile lives at $XDG_CONFIG_HOME/homebrew/Brewfile (homebrew stow package).
  alias bruc="brew update && brew bundle --global && brew cleanup"
fi

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
fi
