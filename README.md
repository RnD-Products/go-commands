# go-commands

Shortcut commands for Claude Code. Install once per device; they work in any project.

| Say | What it does |
|---|---|
| `go pr` | Save the current project to GitHub as a pull request (if the repo is not found on GitHub, it creates a new private repo and pushes to `main`; PRs start from the next change) |
| `go update` | Update the current project from GitHub (old copy goes to the Trash on macOS, or to `~/go-update-backups/` elsewhere) |
| `goapp update` | Check first; update only if the project is behind GitHub |

The "project" is the folder you open Claude Code in, and the GitHub repo is that folder's own `origin`. No setup per project.

## Install

```bash
git clone https://github.com/RnD-Products/go-commands.git ~/go-commands
~/go-commands/install.sh
```

Restart Claude Code. (`go pr` and `go update` need `gh auth login` once per device.) Options: `--project` (current project only), `--link` (symlink; `git pull` updates instantly), `--owner <org>` (see below).

Works on macOS and Linux. On Windows, install and use it inside WSL (the commands need `bash` and `rsync`).

### Team install: new repos go to your org

By default, when a project is not on GitHub yet, `go pr` creates the new repo under your own account. To create it under a team org instead:

```bash
~/go-commands/install.sh --owner RnD-App
```

This saves the org name in `~/.config/go-commands/owner`. You can still name another owner in the request ("go pr in RnD-Products").

## Update later

```bash
cd ~/go-commands && git pull && ./install.sh
```
