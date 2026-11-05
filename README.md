# go-commands

Shortcut commands for Claude Code. Install once per device; they work in any project.

| Say | What it does |
|---|---|
| `go pr` | Save the current project to GitHub as a pull request (if the repo is not found on GitHub, it suggests pushing the project first, then opens the PR and gives you the link) |
| `go update` | Update the current project from GitHub (old copy goes to the Trash) |
| `goapp update` | Check first; update only if the project is behind GitHub |

The "project" is the folder you open Claude Code in, and the GitHub repo is that folder's own `origin`. No setup per project.

## Install

```bash
git clone https://github.com/RnD-Products/go-commands.git ~/go-commands
~/go-commands/install.sh
```

Restart Claude Code. (`go pr` and `go update` need `gh auth login` once per device.) Options: `--project` (current project only), `--link` (symlink; `git pull` updates instantly).

## Update later

```bash
cd ~/go-commands && git pull && ./install.sh
```
