# Use the systemd user ssh-agent socket on Linux when it is running.
[[ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]] || return 1
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
