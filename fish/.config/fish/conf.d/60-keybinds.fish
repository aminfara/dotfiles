# Custom key bindings.

status is-interactive; or return

# Ctrl-Alt-H — toggle `help` on the current command line.
# Behaviour:
#   • Prompt has text starting with `help ` → strip the `help ` prefix.
#   • Prompt has other text                 → run `help <text>`.
#   • Prompt is empty and last command was
#     `help X`                              → put `X` back on the prompt.
#   • Prompt is empty otherwise             → do nothing.
# Note: needs a terminal that forwards Ctrl-Alt-* (Ghostty ✓, VSCode ✗).
function _help_current_cmd
    set -l cmd (commandline | string trim)

    if test -z "$cmd"
        # Empty prompt: if last command was `help X`, restore `X`.
        set -l last (history --max=1)
        if string match -qr '^\s*help\s+\S' -- "$last"
            set -l stripped (string replace -r '^\s*help\s+' '' -- "$last")
            commandline -r -- "$stripped"
        end
        return
    end

    if string match -qr '^help\s+\S' -- "$cmd"
        # Already prefixed with `help ` — strip it.
        set -l stripped (string replace -r '^help\s+' '' -- "$cmd")
        commandline -r -- "$stripped"
    else
        # Wrap current command line in `help` and execute.
        commandline -r -- "help $cmd"
        commandline -f execute
    end
end
bind ctrl-alt-h _help_current_cmd
