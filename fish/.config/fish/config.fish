# Per-session entry point. Per-tool setup lives in conf.d/*.fish.

status is-interactive; or return

set -g fish_greeting ''
