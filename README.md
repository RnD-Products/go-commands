# Claude commands

Reusable Claude Code commands (skills) for Mo_App. Install once per device and they work in any project.

| Command | What it does |
|---|---|
| `mo-pr` | Save the app, projects, fonts, presets and these commands to GitHub as a pull request |
| `mo-update` | Pull the latest from GitHub into the local Mo_App (full update) |
| `app-update` | Check first; update only if the local Mo_App is behind GitHub |

## Install on any device

```bash
git clone <this-repo-url> ~/claude-commands
cd ~/claude-commands
./install.sh            # global: every project on this device
```

Other modes:

```bash
./install.sh --project  # only the project folder you run it from (./.claude/skills)
./install.sh --link     # symlink, so `git pull` updates the commands instantly
```

Restart Claude Code, then say "mo pr", "mo update" or "app update".

## Update commands later

```bash
cd ~/claude-commands && git pull && ./install.sh
```

## Add a new command

Create `skills/<name>/SKILL.md` (with `name` and `description` frontmatter), commit, and re-run `./install.sh`.

## Folder path

The commands assume the app lives at `~/Documents/Mo_App`. If yours is elsewhere, tell Claude the path when you start ("FOLDER: /path/to/Mo_App").
