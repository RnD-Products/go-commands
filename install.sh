#!/usr/bin/env bash
# Install these Claude Code commands (skills) on this device.
#   ./install.sh               -> global: ~/.claude/skills  (works in every project)
#   ./install.sh --project     -> this project only: ./.claude/skills (run from the project folder)
#   ./install.sh --link        -> symlink instead of copy, so `git pull` updates them instantly
#   ./install.sh --owner ORG   -> `go pr` creates new repos under ORG (a GitHub org or user) instead of your own account
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"
DEST="$HOME/.claude/skills"; LINK=0; OWNER=""
while [ $# -gt 0 ]; do
  case "$1" in
    --project) DEST="$PWD/.claude/skills" ;;
    --link) LINK=1 ;;
    --owner) [ $# -ge 2 ] || { echo "--owner needs a GitHub org or user name" >&2; exit 1; }; OWNER="$2"; shift ;;
    --owner=*) OWNER="${1#--owner=}" ;;
    -h|--help) sed -n '2,6p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
  shift
done
if [ -n "$OWNER" ]; then
  case "$OWNER" in
    -*|*[!A-Za-z0-9-]*) echo "Not a valid GitHub org or user name: $OWNER" >&2; exit 1 ;;
  esac
fi
mkdir -p "$DEST"
for dir in "$SRC"/*/; do
  name="$(basename "$dir")"
  rm -rf "${DEST:?}/$name"
  if [ "$LINK" = 1 ]; then ln -s "${dir%/}" "$DEST/$name"; else cp -R "${dir%/}" "$DEST/$name"; fi
  echo "installed $name -> $DEST/$name"
done
if [ -n "$OWNER" ]; then
  CONF="${XDG_CONFIG_HOME:-$HOME/.config}/go-commands"
  mkdir -p "$CONF"
  printf '%s\n' "$OWNER" > "$CONF/owner"
  echo "go pr will create new repos under: $OWNER  (saved in $CONF/owner)"
fi
echo "Done. Restart Claude Code, then say: go pr  |  go update  |  goapp update"
