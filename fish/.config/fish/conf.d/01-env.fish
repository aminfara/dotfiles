# XDG paths, locale, editor.

set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME;   or set -gx XDG_DATA_HOME   $HOME/.local/share
set -q XDG_CACHE_HOME;  or set -gx XDG_CACHE_HOME  $HOME/.cache
set -q XDG_STATE_HOME;  or set -gx XDG_STATE_HOME  $HOME/.local/state

set -gx LANG   en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx TERM xterm-256color

if command -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx GIT_EDITOR nvim
end

if command -q bat
    set -gx MANROFFOPT -c  # prevent raw escape codes in man pages piped through bat
    set -gx BAT_PAGER  less
    set -gx MANPAGER   "sh -c 'col -bx | bat --style=plain --language=man'"
    set -gx PAGER      "bat --paging=always --style=plain"
end
