---
name: proj-check
description: Check whether the local project matches GitHub and update only if it is behind, using claude-commands.json. Use when the user types /proj-check or says "proj check", "app update", "check update", "am I up to date".
---

# proj-check: update only when behind

Read `claude-commands.json` (project root, else `~/.claude/claude-commands.json`). If missing, run `proj-init`.

1. Fresh clone of `branch` of `repo` into the scratchpad.
2. Compare without changing anything: `rsync -rcn --delete --itemize-changes` for `appDir` vs `<repoAppDir>/` (with `exclude`) and each `extraFolders` pair. Also note local-only files (never overwritten) and whether local git is behind `origin/<branch>`.
3. If everything matches, say "up to date" and stop.
4. If behind, show a short list of what differs, then run the `proj-update` procedure (GitHub wins for app code; local-only data stays; differing data is saved as copies; old app to the Trash). If local app files are newer than GitHub's, do not overwrite: tell the user and suggest `proj-pr`.
