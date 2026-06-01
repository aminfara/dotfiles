# Per-session entry point. Per-tool setup lives in conf.d/*.fish.

if status is-interactive
    set -g fish_greeting ''
end
