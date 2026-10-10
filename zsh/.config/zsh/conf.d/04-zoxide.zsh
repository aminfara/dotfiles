(( $+commands[zoxide] )) || return 1
eval "$(zoxide init zsh --cmd cd)"  # defines cd and cdi
