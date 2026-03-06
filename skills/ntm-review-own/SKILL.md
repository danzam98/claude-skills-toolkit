---
name: ntm-review-own
description: Agent self-review to catch bugs in recently written code
version: 1.0.0
author: Daniel Fischer
category: debugging
tags: ["ntm", "multi-agent", "swarm", "review", "debugging"]
---
# Review Your Own Code

Great, now I want you to carefully read over all of the new code you just wrote and other existing code you just modified with "fresh eyes" looking super carefully for any obvious bugs, errors, problems, issues, confusion, etc.

Carefully fix anything you uncover. Use ultrathink.

Check for:
- Logic errors
- Off-by-one mistakes
- Null/undefined handling
- Error handling gaps
- Type mismatches
- Missing edge cases
- Security vulnerabilities (XSS, injection, etc.)
- Performance issues
- Accessibility problems
- Compliance with AGENTS.md rules

After fixing issues, run:
```bash
bun run typecheck
bun run lint
```

Fix any errors that appear. Repeat until clean.

## When to Use

- After an agent completes a bead
- Before moving to the next task
- As a quality gate in the workflow

## Tips

- Should be run after each bead completion
- Catches issues before cross-agent review
- Ensures code meets project standards
