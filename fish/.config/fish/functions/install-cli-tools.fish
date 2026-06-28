# Idempotent brew install/upgrade for the CLI toolset this fish config expects.
# Safe to re-run any time to bring tools up to date.

function install-cli-tools --description 'Install/upgrade brew CLI tools used by this fish config'
    if not command -q brew
        echo "✗ brew not found. Install Homebrew first: https://brew.sh"
        return 1
    end

    # Common tools — one per line for easy edit.
    set -l pkgs \
        bat \
        btop \
        eza \
        fd \
        fish \
        fzf \
        git \
        git-delta \
        lazygit \
        mise \
        neovim \
        ripgrep \
        starship \
        stow \
        yazi \
        zoxide


    # OS-conditional extras.
    switch (uname)
        case Darwin
            set -a pkgs \
                gnupg \
                coreutils \
                gnu-sed
        case Linux
            # set -a pkgs <linux-specific packages here>
    end

    echo "▸ Installing missing packages…"
    brew install --formula $pkgs
    or return 1

    echo "▸ Upgrading outdated packages…"
    brew upgrade --formula $pkgs
    or return 1

    echo "✓ Tools reconciled ("(count $pkgs)" packages)."
end
