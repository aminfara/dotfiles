# The claude cask ships no zsh completion. _gnu_generic builds one from --help.
(( $+commands[claude] )) || return 1
compdef _gnu_generic claude
