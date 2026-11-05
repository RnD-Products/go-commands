# go-commands

Shortcut commands for Claude Code. Install once per device; they work in any project.

| Say | What it does |
|---|---|
| `go pr` | Save the current project to GitHub as a pull request |
| `go update` | Update the current project from GitHub (old copy goes to the Trash) |
| `gogoapp update` | Check first; update only if the project is behind GitHub |

The "project" is the folder you open Claude Code in, and the GitHub repo is that folder's own `origin`. No setup per project.

## Install

```bash
gh repo clone uiux-subash/go-commands ~/go-commands
~/go-commands/install.sh
```

Restart Claude Code. (Needs `gh auth login` once per device.) Options: `--project` (current project only), `--link` (symlink; `git pull` updates instantly).

## Update later

```bash
cd ~/go-commands && git pull && ./install.sh
```
