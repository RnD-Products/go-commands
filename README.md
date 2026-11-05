# Claude commands

Install this repo on any device and these commands work in Claude Code, in any project:

| Say | What it does |
|---|---|
| `mo pr` | Save the app, projects, fonts, presets and these commands to GitHub as a pull request |
| `mo update` | Full update of the local Mo_App from GitHub (old app goes to the Trash) |
| `app update` | Check first; update only if the local Mo_App is behind GitHub |

## Install

```bash
gh repo clone uiux-subash/claude-commands ~/claude-commands
~/claude-commands/install.sh
```

Restart Claude Code. Done. (Needs `gh auth login` once per device.)

Options: `./install.sh --project` (only the current project), `./install.sh --link` (symlink; `git pull` updates instantly).

## Update later

```bash
cd ~/claude-commands && git pull && ./install.sh
```

## Folder path

The commands use `~/Documents/Mo_App`. If yours is elsewhere, tell Claude when you start: "FOLDER: /path/to/Mo_App".
