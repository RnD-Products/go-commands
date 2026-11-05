---
name: app-update
description: Check if the local Mo_App folder matches GitHub (mr-imruu/Mo_App_v.02 main) and, only if it is behind, update it from GitHub (app code, projects, fonts, presets) without losing local work. Use when the user types /app-update or says "app update", "update app", "sync app", "check app update" while working on Mo_App, at home or at the office.
---

# App update: make the local folder match GitHub, only when needed

`app update` is the quick, safe version of `mo update`: it first checks, and changes nothing when the local folder is already the same as GitHub. When it is behind, GitHub wins for the app code, and nothing the user could still need is lost (old app goes to the Trash, local-only projects stay, differing projects are saved as copies).

## Folders (two computers)
- **Office computer:** `~/Documents/Mo_App`
- **Home computer:** `~/Documents/Coding/Imruu/Mo_App`
Call the folder that exists `FOLDER` (office first, then home; if the user names another path, use it). `FOLDER` holds `Mo_App_v.02/`, `Projects/`, `Fonts/`, `Presets/`, `Recovered/`. Never switch branches, stash, `git clean` or hard-reset in `FOLDER` (see its `CLAUDE.md`). Run every step without asking again, except where a step says to stop. Node is in `/opt/homebrew/bin`.

## Steps

1. **Fetch GitHub into a scratch folder** (not into FOLDER): `gh repo clone mr-imruu/Mo_App_v.02 <scratch>/gh -- -q` (retry up to 3 times on a network error). Its layout: `Mo_App_v.02/` (the app), `Projects/`, `Fonts/`, `Presets/`. Note the latest commit (`git -C <scratch>/gh log -1 --format='%h %s'`).

2. **Compare (read only), then decide.**
   - App code: `diff -rq --exclude node_modules --exclude .git --exclude dist --exclude .toolcraft --exclude .DS_Store <scratch>/gh/Mo_App_v.02 FOLDER/Mo_App_v.02` -> `APPDIFF` (list of differing or missing files).
   - Projects: for each `.json` in GitHub `Projects/`: missing locally, or different from the local file -> `PROJDIFF`.
   - Fonts and Presets: files in GitHub missing locally -> `NEWFILES`.
   - Local work: `git -C FOLDER fetch -q origin main`; `EDITED` = the app files that `git -C FOLDER status --short -- Mo_App_v.02` lists as modified or untracked (changed locally since the last sync). `LOCALWORK` = the files that are in BOTH `APPDIFF` and `EDITED` (changed locally AND different from GitHub). A file edited locally that is already identical on GitHub (for example after your own `mo pr` was merged) is NOT local work, and a file that differs from GitHub but was not edited locally just means GitHub is newer (safe to take).
   - **Already up to date** (APPDIFF empty, no PROJDIFF that needs changing, NEWFILES empty): say "App is already up to date with GitHub (commit <hash> <subject>)", make sure the git record matches (`git -C FOLDER reset -q origin/main`, a plain reset that never touches files; this also clears the false "modified" list), and STOP. Do not trash, install or start anything.

3. **Protect local work.** If `LOCALWORK` is not empty, the local folder is AHEAD of GitHub for those files. Then STOP and tell the user: "Your local folder has changes that are not on GitHub (N files, e.g. <first 5>). Run `mo pr` first, then merge, then `app update`. Say `app update force` if GitHub should win and your local app changes should go to the Trash." Only continue past this step when `LOCALWORK` is empty, or the user said "force" (or "github wins"); with force, the old app folder still goes to the Trash first, and say how many local files were replaced.

4. **Projects** (same rules as mo-update; never remove or overwrite a project that has only local work):
   - New on GitHub: copy to `FOLDER/Projects`.
   - Same name, different: if the GitHub file is byte-identical to `FOLDER/Recovered/<name>.json` (the autosave), or the old local copy is byte-identical to some file in `FOLDER/Recovered`, overwrite the local project with the GitHub one (nothing lost, an autosave holds the old one). Otherwise keep the local file and save the GitHub one as `<name> (github).json`.
   - Fonts and Presets: copy files that are missing locally; never overwrite or delete a local file.
   - Leave `FOLDER/Recovered` untouched.

5. **App code** (only when APPDIFF is not empty):
   - If a dev server is listening on 3002/3011, note it (`lsof -ti tcp:3002 -sTCP:LISTEN`). Do not kill a server the user runs in their own terminal; at the end tell them to restart it (`npm run dev:restart`, or stop and `npm run dev`) because the autosave helper keeps old code in memory. If the user asked earlier to pause the server, never start one.
   - Move the old `FOLDER/Mo_App_v.02` to `~/.Trash/Mo_App_v.02 old <YYYY-MM-DD>` (add a number if that name exists). Never hard-delete.
   - Copy GitHub's app: `rsync -a --exclude .git <scratch>/gh/Mo_App_v.02/ FOLDER/Mo_App_v.02/`.
   - Move the old `node_modules` back into the new app folder (saves a long install): `mv "<trash>/Mo_App_v.02 old.../node_modules" FOLDER/Mo_App_v.02/node_modules` if it exists.
   - If `package.json` or `package-lock.json` changed (they are in APPDIFF) or `node_modules` is missing: `npm install --no-audit --no-fund` in `FOLDER/Mo_App_v.02`. Otherwise skip the install.
   - `git -C FOLDER fetch -q origin main && git -C FOLDER reset -q origin/main` (plain reset; moves the record, never the files).

6. **Check:** `npx tsc --noEmit -p tsconfig.json` in `FOLDER/Mo_App_v.02` (only when app code changed). Report errors; do not start the app unless the user asks.

7. **Report in a few lines** (plain English): "Already up to date" or "Updated from GitHub to <hash> <subject>"; how many app files changed (and the first few names); projects added, replaced, or saved as `(github)` copies; where the old app went in the Trash; whether a server needs a restart; the tsc result. End with the short "Stage" line if the project rules ask for it.

## Notes
- It never pushes to GitHub. To send local work to GitHub use `mo pr`.
- After a PR merge, `app update` and `mo update` give the same result; use `app update` any time (it is safe and quick when nothing changed).
