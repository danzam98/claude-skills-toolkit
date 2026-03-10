---
name: ntm-review-others
description: Cross-agent code review to catch integration issues
version: 2.0.0
author: Daniel Fischer
category: debugging
tags: ["ntm", "multi-agent", "swarm", "review", "peer-review"]
---
# Cross-Agent Code Review

Review code written by your fellow agents. Check for bugs, errors, inefficiencies, security problems, and reliability issues. Diagnose root causes using first-principles analysis. Fix or revise where necessary.

Don't restrict yourself to the latest commits — cast a wide net and go deep. Use ultrathink.

## Review Process

### 1. Survey recent agent work

```bash
git log --oneline -20
```

For each commit from other agents:
- `git show <sha>` to see the full diff
- Trace the code paths affected
- Look for integration issues with your own work
- Check for violations of AGENTS.md rules or project conventions

### 2. Go deeper where warranted

Use `./robot files [query]` (or explore the directories described in AGENTS.md) to find related files that might be affected by the changes. Don't limit review to just the diff — understand the full impact radius.

### 3. Common issues to watch for

- Inconsistent patterns across files (different agents solving the same problem differently)
- Broken or missing imports after refactoring
- Duplicate code that should be in a shared location
- Race conditions in async code
- Missing error boundaries or graceful degradation
- Memory leaks in effects, subscriptions, or event listeners
- Security vulnerabilities introduced by new code
- AGENTS.md rule violations (wrong package manager commands, attempted file deletion, etc.)
- Hardcoded values that should reference project design tokens or config

### 4. Fix what you find

Fix issues directly. Understand the root cause before patching the symptom. Match existing project conventions — do not introduce new patterns.

### 5. Run full verification

Run the check commands from AGENTS.md's Quick Reference (build, typecheck, lint, test — whatever applies to this project). Fix all errors before committing your review fixes.

```bash
# Use whatever AGENTS.md specifies, for example:
# ./robot build       (if ./robot is available)
# npm run build       (mockup phase)
# bun run typecheck && bun run lint  (production phase)
```

### 6. Notify original agents

Via MCP Agent Mail, inform the agent whose code you modified what you found and why you changed it. This keeps the swarm aligned and prevents agents from redoing work in conflicting ways.

---

## When to Use

- Periodically during swarm sessions (every few beads)
- When multiple agents have been working in parallel
- Before major commits or releases
- When integration issues are suspected

## Tips

- Catches issues that self-review misses — especially cross-agent consistency
- Always notify the original agent; don't silently rewrite their work
- Commit review fixes via the git manager like any other code change
