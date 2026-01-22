alias c="clear"

alias path="tr ':' '\\n' <<< \$PATH"
alias fpath="tr ':' '\\n' <<< \$FPATH"

# Process related aliases
alias psg="pgrep -ilf"
alias psgg="ps aux | grep -v grep | grep"
alias pst="pstree -g3 -s"
