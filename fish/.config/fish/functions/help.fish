# Render --help output through bat with syntax highlighting.
# Usage: help git   help eza   help fish
# Fish has no global aliases, so this replaces `cmd --help | bat`.

function help --description 'Render --help output through bat'
    if not command -q bat
        $argv --help
        return
    end
    $argv --help 2>&1 | bat --language=help --style=plain --paging=never
end
