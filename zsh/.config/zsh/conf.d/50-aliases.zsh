alias c="clear"

alias path="tr ':' '\\n' <<< \$PATH"
alias fpath="tr ':' '\\n' <<< \$FPATH"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# z1 aliases help to run-help; functions/help replaces it.
unalias help 2>/dev/null

if (( $+commands[brew] )); then
  # Brewfile lives in the homebrew stow package. --global does not find it
  # through the stow symlink in every setup, so pass the path.
  alias bruc='brew update && brew bundle --file="${XDG_CONFIG_HOME:-$HOME/.config}/homebrew/Brewfile" && brew upgrade --yes && brew cleanup'
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
  alias lt="lsi --tree --level=2 --git-ignore --ignore-glob='.git|node_modules'"
fi

if (( $+commands[bat] )); then
  alias cat="bat --paging=never --style=plain"
fi
