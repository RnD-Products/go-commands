---
name: proj-update
description: Update the current project from GitHub, using claude-commands.json - merge extra folders safely, replace the app folder (old one to Trash), install, and run it once. Use when the user types /proj-update or says "proj update", "mo update", "update from github".
---

# proj-update: full update from GitHub

Read `claude-commands.json` (project root, else `~/.claude/claude-commands.json`). If missing, run `proj-init` first. Never hard-delete: old folders go to the macOS Trash and user data files are never removed. Do not ask again for the steps below.

1. Clone `branch` of `repo` fresh into the scratchpad.
2. For each `extraFolders` item, merge `<repo>/` into `<local>/`: copy files that are new; for a same-named file that differs, overwrite only if the old local copy is byte-identical to a file in `pushAutosaves` (still kept), otherwise save GitHub's as `<name> (github).<ext>`. If GitHub's file equals the same-named autosave, overwrite the local one with it. Never delete local files; leave `pushAutosaves` untouched.
3. Stop any dev server for `devUrl`'s port. Move `appDir` to `~/.Trash/<name> old <YYYY-MM-DD>` (add a number if it exists), then `rsync -a --exclude .git` the repo's `<repoAppDir>/` into `appDir`. If `appDir` is the git root, keep local `.git` and `exclude`d dirs and merge instead of trashing.
4. If `appDir` (or its parent) is a git checkout of `repo`: `git fetch -q origin <branch> && git reset -q origin/<branch>` (plain reset, files untouched). Never switch branches, stash or hard-reset.
5. In `appDir`: `installCmd`, then `checkCmd`, then start `devCmd` in the background; wait for `devUrl` and open it once (`preview_start` `previewName`), checking the console.
6. Report: what was added, replaced, renamed (github) or skipped; where the old app went in the Trash; latest commit; and whether the app opened.
