#!/usr/bin/env bash
# Install these Claude Code commands (skills) on this device.
#   ./install.sh            -> global: ~/.claude/skills  (works in every project)
#   ./install.sh --project  -> this project only: ./.claude/skills (run from the project folder)
#   ./install.sh --link     -> symlink instead of copy, so `git pull` updates them instantly
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"
DEST="$HOME/.claude/skills"; LINK=0
for a in "$@"; do
  case "$a" in
    --project) DEST="$PWD/.claude/skills" ;;
    --link) LINK=1 ;;
    -h|--help) sed -n '2,6p' "$0"; exit 0 ;;
    *) echo "Unknown option: $a" >&2; exit 1 ;;
  esac
done
mkdir -p "$DEST"
for dir in "$SRC"/*/; do
  name="$(basename "$dir")"
  rm -rf "${DEST:?}/$name"
  if [ "$LINK" = 1 ]; then ln -s "${dir%/}" "$DEST/$name"; else cp -R "${dir%/}" "$DEST/$name"; fi
  echo "installed $name -> $DEST/$name"
done
echo "Done. Restart Claude Code, then say: mo pr  |  mo update  |  app update"
