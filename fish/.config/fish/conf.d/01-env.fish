# XDG paths, locale, editor.

set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME;   or set -gx XDG_DATA_HOME   $HOME/.local/share
set -q XDG_CACHE_HOME;  or set -gx XDG_CACHE_HOME  $HOME/.cache
set -q XDG_STATE_HOME;  or set -gx XDG_STATE_HOME  $HOME/.local/state

set -gx LANG   en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

if command -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx GIT_EDITOR nvim
end
