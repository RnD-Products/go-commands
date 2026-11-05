# Claude commands

Universal Claude Code commands (skills). Install once per device; they work in any project. Each project describes itself in a small `claude-commands.json`, so nothing is hardcoded.

| Command | What it does |
|---|---|
| `proj-init` | Detects the project and writes `claude-commands.json` |
| `proj-pr` | Saves the app and extra folders to GitHub as a pull request (also "mo pr", "pr") |
| `proj-update` | Full update from GitHub, old app to the Trash (also "mo update") |
| `proj-check` | Updates only if the local project is behind (also "app update") |

## Install on any device

```bash
gh repo clone uiux-subash/claude-commands ~/claude-commands
~/claude-commands/install.sh            # global: every project
```

Other modes: `./install.sh --project` (current project only), `./install.sh --link` (symlink; `git pull` updates instantly).

## Use in a project

1. Open the project in Claude Code and say `proj init` (creates `claude-commands.json`).
2. Then say `proj pr`, `proj update` or `proj check`.

See `claude-commands.example.json` for a full example (the Mo_App setup). A config in `~/.claude/claude-commands.json` is used when a project has none.

## Update commands later

```bash
cd ~/claude-commands && git pull && ./install.sh
```

## Add a new command

Create `skills/<name>/SKILL.md` (with `name` and `description` frontmatter), commit, re-run `./install.sh`.
