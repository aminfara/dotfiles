# PATH bootstrap. Order matters: later fish_add_path -gP wins (prepends).
# Final priority: user > brew > /usr/local.

# 1. System fallback (lowest priority — added first).
for dir in /usr/local/bin /usr/local/sbin
    test -d $dir; and fish_add_path -gPm $dir
end

# 2. Homebrew (mac + Linuxbrew). shellenv also sets MANPATH/INFOPATH/HOMEBREW_*.
for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew /usr/local/bin/brew
    if test -x $brew_bin
        eval ($brew_bin shellenv)
        break
    end

    set -l brew_prefix (brew --prefix)

    if test -d "$brew_prefix/share/fish/vendor_completions.d"
        set --prepend fish_complete_path "$brew_prefix/share/fish/vendor_completions.d"
    end

    if test -d "$brew_prefix/share/fish/completions"
        set --prepend fish_complete_path "$brew_prefix/share/fish/completions"
    end
end

# 3. User bins (highest priority — added last). -m moves dirs already on PATH
# to the front so parent-shell pollution can't demote them.
for dir in $HOME/.local/sbin $HOME/.local/bin $HOME/sbin $HOME/bin
    test -d $dir; and fish_add_path -gPm $dir
end
