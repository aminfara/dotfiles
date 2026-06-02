# Per-tool init. Guarded so missing tools are silent.

status is-interactive; or return

# starship — prompt.
command -q starship; and starship init fish | source

# zoxide — smarter cd. (--cmd cd breaks fish's syntax highlighting.)
command -q zoxide; and zoxide init fish | source

# mise — language tooling; auto-switches versions per project.
command -q mise; and mise activate fish | source

# fzf — bindings provided by PatrickF1/fzf.fish (installed via fisher).
# Do NOT add `fzf --fish | source` here; it conflicts with fzf.fish bindings.
# Note: Ctrl-Alt-* bindings need a terminal that forwards them (Ghostty ✓,
# kitty ✓, Alacritty ✓). Zed's embedded terminal swallows them — use Ghostty.
# TODO: consider customising fzf_preview_dir_cmd (eza) and fzf_diff_highlighter (delta).
