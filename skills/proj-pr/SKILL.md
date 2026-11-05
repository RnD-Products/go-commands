---
name: proj-pr
description: Save the current project to GitHub as a pull request, using claude-commands.json (app folder plus extra folders). Use when the user types /proj-pr or says "proj pr", "mo pr", "save to github", or just "pr".
---

# proj-pr: save the project to GitHub as a pull request

Read `claude-commands.json` (project root, else `~/.claude/claude-commands.json`). If missing, run `proj-init` first. Never merge the PR or force-push unless asked. Do not ask again for the steps below; the user approved this procedure.

1. Clone `branch` of `repo` fresh into the scratchpad (`gh repo clone <repo> <dir> -- -q`); create branch `pr-<YYYY-MM-DD-HHMM>`.
2. App: `rsync -a --delete` from `appDir/` to `<dir>/<repoAppDir>/`, with every `exclude` entry as `--exclude`. If `repoAppDir` is "" never delete the clone's `.git`.
3. For each `extraFolders` item: `rsync -a --delete --exclude .DS_Store <local>/ <dir>/<repo>/` (skip a missing local folder). If `pushAutosaves` is set, copy each autosave file that is newer than (or missing from) the clone's same-named file. Never write into the local folders, only into the clone.
4. `git status --short` in the clone. If many files would be deleted (` D`), stop: the local folder is probably missing work; tell the user. If nothing changed, say so and stop.
5. Run `checkCmd` in `appDir` if set. If it fails, report the errors and ask before pushing.
6. Commit with a message saying what changed, end with the attribution line from the session's system reminder, push the branch, `gh pr create --repo <repo> --base <branch>` with a short summary and test plan.
7. Bind the PR to the session (ccd_pr `get_status`, then `bind_pr` if needed). Report the PR link and what changed; remind the user the work lands on `branch` when they merge.
