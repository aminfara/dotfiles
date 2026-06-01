# Per-tool init. Guarded so missing tools are silent.

status is-interactive; or return

# starship — prompt.
command -q starship; and starship init fish | source

# zoxide — smarter cd. (--cmd cd breaks fish's syntax highlighting.)
command -q zoxide; and zoxide init fish | source
