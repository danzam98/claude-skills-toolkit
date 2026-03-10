---
name: ntm-review-own
description: Agent self-review to catch bugs in recently written code
version: 2.0.0
author: Daniel Fischer
category: debugging
tags: ["ntm", "multi-agent", "swarm", "review", "debugging"]
---
# Review Your Own Code

Read over all of the new code you just wrote and all existing code you just modified with fresh eyes. Look carefully for any obvious bugs, errors, problems, issues, or confusion. Fix anything you uncover. Use ultrathink.

## What to Check

- Logic errors and off-by-one mistakes
- Null/undefined/empty handling
- Error handling gaps — what happens on failure?
- Type mismatches or incorrect assumptions about data shape
- Missing edge cases
- Security vulnerabilities (XSS, injection, exposed values, etc.)
- Performance issues (blocking operations, unnecessary work, N+1 patterns)
- Accessibility problems (missing labels, keyboard traps, color contrast)
- Compliance with all rules in AGENTS.md
- Conformance to best practice guides referenced in AGENTS.md

## After Fixing Issues

Run the check commands from AGENTS.md's Quick Reference section. These vary by project and phase — use the exact commands specified there, not any assumed default:

```bash
# Use whatever AGENTS.md specifies, for example:
# ./robot build       (if ./robot is available)
# npm run build       (mockup phase)
# bun run typecheck   (production phase)
# bun run lint        (production phase)
```

Fix any errors that appear. Repeat until clean.

## When to Use

- After completing a bead — this is a required quality gate before closing
- Before handing off work to the git manager
- Whenever you feel uncertain about something you just wrote

## Tips

- Read the code as if someone else wrote it — suspend authorial familiarity
- Pay extra attention to the first and last lines of functions — edge cases cluster there
- If a check command doesn't exist yet (e.g., scaffold not built), note it and move on
