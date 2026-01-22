[[ ! -f "$HOME"/.fzf.zsh ]] && return 1

if (( $+commands[fd] )); then
  fzf_compgen_path() {
    fd --exclude ".git" --follow --hidden . "$1"
  }

  fzf_compgen_dir() {
    fd --exclude ".git" --follow --hidden --type d . "$1"
  }

  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
fi

if (( $+commands[bat] )); then
  export FZF_PREVIEW_COMMAND='bat --style=numbers --color=always --line-range :500 {} || cat {}'
else
  export FZF_PREVIEW_COMMAND='head -500 {}'
fi

export FZF_CTRL_T_OPTS="--preview \"$FZF_PREVIEW_COMMAND\""

bindkey ç fzf-cd-widget

source "$HOME"/.fzf.zsh
