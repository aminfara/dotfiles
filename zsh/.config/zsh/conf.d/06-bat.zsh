(( $+commands[bat] )) || return 1
export BAT_THEME="ansi"  # follows the terminal palette (Ghostty Ayu Mirage)
export BAT_PAGER="less"
export MANPAGER="sh -c 'col -bx | bat --style=plain --language=man'"
export PAGER="bat --paging=always --style=plain"
export MANROFFOPT="-c"  # prevent raw escape codes in man pages piped through bat
