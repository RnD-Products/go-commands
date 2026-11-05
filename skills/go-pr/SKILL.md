---
name: go-pr
description: Save the current project to GitHub as a pull request. Use when the user types /go-pr or says "go pr", "Go pr", "Go PR", or just "pr".
---

# go pr: save this project to GitHub as a pull request

Works in any project. The project is the folder Claude Code is open in (its git root); the GitHub repo is that folder's `origin`. Run every step without asking again; the user approved this procedure. Never merge the PR or force-push unless asked.

1. Find the project: `git rev-parse --show-toplevel` (not a git repo: use the current folder). Check whether it is on GitHub: `git remote get-url origin` and `gh repo view <origin>` must both succeed.
   - **Not on GitHub yet** (no git repo, no `origin`, or the repo does not exist): before the user agrees, push nothing. Say: "Repo not found on GitHub. Suggestion: push this project to GitHub first, then `go pr` works. Push it now?" and wait for a clear yes (if no, stop). On yes, ask once for the owner (default: the `gh` login, or an org the user names), the repo name (default: the folder name) and visibility (default: private; never public without a clear yes). Then: `git init -b main` if needed, add a `.gitignore` if none exists (`node_modules`, `dist`, `.env*`, `.DS_Store`), scan the files for secrets (`.env`, keys, tokens) and stop to ask if any are found. Commit the whole project on `main` ("Initial commit" + the attribution line from the session's system reminder) and `gh repo create <owner>/<name> --<private|public> --source=. --remote=origin --push`. The first push goes to `main` itself, never to a side branch, so the repo's default branch holds the full project. Verify with `gh repo view --json defaultBranchRef` and `git ls-remote origin main`. Report the repo URL and say: "Pushed to main. From your next change on, `go pr` opens a PR." Do not open a PR (there is nothing to compare yet). Stop here.
   - **On GitHub**: read `origin` and the default branch (`main` or `master`) and continue.
2. Do not touch the user's current branch. Make a safe copy: `git worktree add` (or a fresh `gh repo clone` into the scratchpad) on a new branch `go-pr-<YYYY-MM-DD-HHMM>` from the default branch, then rsync the project files in (`rsync -a --delete`, excluding `.git`, `node_modules`, `dist`, `.DS_Store`, `.env*`, and anything in `.gitignore`).
3. `git status --short`. If nothing changed, say so and stop. If many files would be deleted (` D`), stop and tell the user: the local folder is probably missing work.
4. If the project has a check script (`package.json` typecheck/test, `Makefile`, etc.), run it; if it fails, report the errors and ask before pushing.
5. Commit with a message saying what changed, ending with the attribution line from the session's system reminder. Push the branch and `gh pr create --base <default branch>` with a short summary and test plan (PR body attribution line from the system reminder). If the project has `.github/pull_request_template.md`, fill in its sections for the PR body.
6. Bind the PR to the session (ccd_pr `get_status`, then `bind_pr` if needed). Report the PR link and the files changed; remind the user the work lands on the default branch when they merge.
