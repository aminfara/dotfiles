# Interactive aliases.

status is-interactive; or return

# zoxide — alias (not abbr) so history records `cd`, not the expanded `z`.
if command -q zoxide
    alias cd  'z'
    alias cdi 'zi'
end

# eza — flags repeated verbatim per entry for easy diffing.
if command -q eza
    alias ls  'eza'
    alias lsi 'eza --group-directories-first --icons'
    alias ll  'eza --group-directories-first --icons -l'
    alias la  'eza --group-directories-first --icons -al'
    alias l   'eza --group-directories-first --icons -aal'
end
