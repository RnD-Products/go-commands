# Contributing to go-commands

Thanks for helping. Changes reach `main` only through a pull request that someone else reviews.

## Try it locally

```bash
git clone https://github.com/RnD-Products/go-commands.git ~/go-commands
~/go-commands/install.sh --link   # symlink: your edits apply instantly
```

Restart Claude Code, then test `go pr`, `go update` and `goapp update` in a throwaway project.

## Propose a change

1. Branch from `main` (or just say `go pr` in this repo; it makes the branch and PR for you).
2. Edit `skills/<command>/SKILL.md` (the instructions Claude follows) or `install.sh`.
3. Fill in the PR template: what changed, why, how you tested.
4. Wait for a review. Do not push to `main` directly.

## Before opening a PR

- `bash -n install.sh` passes.
- No secrets, tokens, emails or personal paths in the diff.
- If a command's behaviour changed, update `README.md`.
- Keep commands generic: they work in any project (project = the folder Claude Code is open in, repo = its `origin`).

## Reviewing

Read the changed `SKILL.md` as the instructions Claude will run on other people's machines. Check that nothing deletes data without going to the Trash (or the backup folder on non-macOS systems), pushes to `main`, or merges without being asked.
