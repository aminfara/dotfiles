#!/usr/bin/env bash
# Link the global Claude instructions and the dotfiles-owned skills into ~/.claude.
# Idempotent. Refuses to replace a real file or directory.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="${CLAUDE_HOME:-$HOME/.claude}"
skills=(programming writing-studio)

link() {
  local target="$1" name="$2"
  if [[ -e "$name" && ! -L "$name" ]]; then
    echo "skip: $name exists and is not a symlink" >&2
    return 1
  fi
  ln -sfn "$target" "$name"
  echo "linked: $name -> $target"
}

mkdir -p "$dest/skills"
status=0
link "$src/global-claude.md" "$dest/CLAUDE.md" || status=1
for skill in "${skills[@]}"; do
  link "$src/skills/$skill" "$dest/skills/$skill" || status=1
done
exit "$status"
