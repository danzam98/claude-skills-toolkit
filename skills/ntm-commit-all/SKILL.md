---
name: ntm-commit-all
description: Commit all pending changes in logical groupings
version: 2.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "git", "commit"]
---
# Commit All Changes

Commit all changed files in logically connected groupings with detailed commit messages. Do not edit any code. Do not commit ephemeral files. Use ultrathink.

## Process

### 1. Review all changes

```bash
git status
git diff
```

### 2. Sync beads before committing

Always flush the beads database and stage `.beads/` so code and tracking stay in sync:

```bash
# Preferred:
./robot sync

# Fallback:
br sync --flush-only
git add .beads/
```

### 3. Group changes logically

Group by:
- Feature or component
- Commit type (feat, fix, chore, docs, test)
- Related functionality that belongs together

### 4. Commit each group

Stage specific files — never `git add -A` blindly:

```bash
git add <specific-files>
git commit -m "$(cat <<'EOF'
<type>(<scope>): <short description>

<detailed body:>
- What was changed
- Why it was changed
- Any important implementation details

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### 5. Verify with project check commands

Run the check commands specified in AGENTS.md's Quick Reference section. These vary by project and by development phase — use whatever applies (build, typecheck, lint, test):

```bash
# Example — use the actual commands from AGENTS.md, not these:
# npm run build      (mockup phase)
# bun run typecheck  (production phase)
# bun run lint       (production phase)
```

If any check fails, fix the issue before proceeding. Do not commit broken code.

### 6. Notify the git manager

Do **NOT** run `git push` yourself. Send a message via MCP Agent Mail to the git manager summarizing what was committed and requesting a push. Include:
- The commit SHA(s)
- A one-line summary of what changed
- Any CI concerns to watch for

## Files to NEVER Commit

- `.env`, `.env.local` — secrets
- `node_modules/`, `.next/`, `dist/`, `out/` — build artifacts and dependencies
- `*.log` files
- `.DS_Store`
- Temporary or backup files

## When to Use

- After significant work is completed
- Before ending a swarm session
- When directed by the git manager to consolidate changes

## Tips

- Best invoked on the git manager agent; worker agents should notify the git manager instead
- Commit `.beads/` alongside code — never separate them
- Always run project checks before committing; never commit broken code
- Do not amend commits already pushed to the remote
