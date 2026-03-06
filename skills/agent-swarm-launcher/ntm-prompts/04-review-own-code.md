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
