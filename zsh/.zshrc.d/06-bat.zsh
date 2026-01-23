(( $+commands[bat] )) || return 1
export BAT_THEME="Catppuccin Mocha"
export BAT_PAGER="less"
export MANPAGER="sh -c 'col -bx | bat --style=plain --language=man'"
export PAGER="bat --paging=always --style=plain"
