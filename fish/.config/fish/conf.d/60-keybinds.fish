# Custom key bindings.

status is-interactive; or return

# Ctrl-Alt-H — wrap current command line in `help` and execute.
# e.g. type `docker ps`, press Ctrl-Alt-H → runs `help docker ps`.
# Note: needs a terminal that forwards Ctrl-Alt-* (Ghostty ✓, VSCode ✗).
function _help_current_cmd
    set -l cmd (commandline)
    commandline "help $cmd"
    commandline -f execute
end
bind ctrl-alt-h _help_current_cmd
