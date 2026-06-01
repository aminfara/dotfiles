#!/usr/bin/env fish
# Bootstrap: brew CLI tools + fisher + fish plugins. Idempotent.
# Run: fish ~/.config/fish/install.fish

# 1. CLI tools via brew.
if functions -q install-cli-tools
    install-cli-tools
    or exit 1
else
    echo "✗ install-cli-tools function missing — is functions/ stowed correctly?"
    exit 1
end

# 2. fisher (plugin manager).
if not functions -q fisher
    echo "▸ Installing fisher…"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    and fisher install jorgebucaran/fisher
    or begin
        echo "✗ fisher install failed"
        exit 1
    end
end

# 3. Sync plugins listed in fish_plugins.
echo "▸ Syncing plugins…"
fisher update
or begin
    echo "✗ fisher update failed"
    exit 1
end

echo "✓ Done. Run `exec fish` to load new bindings."
