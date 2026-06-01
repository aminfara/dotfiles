#!/usr/bin/env fish
# Bootstrap fisher + sync plugins listed in fish_plugins. Idempotent.
# Assumes fish ≥ 4.0 and all CLI deps are already installed.
# Run: fish ~/.config/fish/install.fish

if not functions -q fisher
    echo "▸ Installing fisher…"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    and fisher install jorgebucaran/fisher
    or begin
        echo "✗ fisher install failed"
        exit 1
    end
end

echo "▸ Syncing plugins…"
fisher update
or begin
    echo "✗ fisher update failed"
    exit 1
end

echo "✓ Done. Run `exec fish` to load new bindings."
