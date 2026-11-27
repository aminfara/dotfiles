#!/usr/bin/env bash
# Link the global Claude instructions into ~/.claude. Skills live in the orchestra plugin.
# Idempotent. Refuses to replace a real file or directory.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="${CLAUDE_HOME:-$HOME/.claude}"

link() {
  local target="$1" name="$2"
  if [[ -e "$name" && ! -L "$name" ]]; then
    echo "skip: $name exists and is not a symlink" >&2
    return 1
  fi
  ln -sfn "$target" "$name"
  echo "linked: $name -> $target"
}

status=0
link "$src/global-claude.md" "$dest/CLAUDE.md" || status=1
exit "$status"
