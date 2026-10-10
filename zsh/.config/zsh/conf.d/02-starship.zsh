(( $+commands[starship] )) || return 1

export STARSHIP_CONFIG=${ZDOTDIR}/starship.toml
eval "$(starship init zsh)"
