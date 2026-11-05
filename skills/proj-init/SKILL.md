---
name: proj-init
description: Create claude-commands.json for the current project so proj-pr, proj-update and proj-check know the project's folder, GitHub repo and commands. Use when the user types /proj-init, says "proj init", "init project commands", or when another proj-* command finds no config.
---

# proj-init: configure the project commands

Write `claude-commands.json` in the project root (the git root, or the current folder if there is no git). Detect first, ask only for what you cannot detect.

Detect: `git remote get-url origin` -> `repo` (`owner/name`), `git symbolic-ref --short refs/remotes/origin/HEAD` -> `branch` (default `main`); `package.json` scripts -> `installCmd`, `checkCmd` (typecheck/test), `devCmd`, and a port from the dev config -> `devUrl`; `.claude/launch.json` name -> `previewName`.

Schema (all keys optional except `repo`):

```json
{
  "repo": "owner/name",
  "branch": "main",
  "appDir": ".",
  "repoAppDir": "",
  "extraFolders": [
    { "local": "~/Documents/Thing/Projects", "repo": "Projects", "pushAutosaves": "~/Documents/Thing/Recovered" }
  ],
  "exclude": ["node_modules", "dist", ".git", ".DS_Store"],
  "installCmd": "npm install --no-audit --no-fund",
  "checkCmd": "npx tsc --noEmit",
  "devCmd": "npm run dev",
  "devUrl": "http://127.0.0.1:3000/",
  "previewName": "dev"
}
```

- `appDir`: the local app folder (absolute, `~` allowed, or relative to the config file). `repoAppDir`: its folder inside the repo ("" = repo root).
- `extraFolders`: other local folders mirrored to a repo folder (data, assets, docs). `pushAutosaves` is optional: a local folder of newer autosaves that win over the same-named file.

Show the user the detected file, ask for corrections, then save. Do not commit it unless asked.
