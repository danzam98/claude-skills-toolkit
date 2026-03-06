# Cross-Agent Code Review

Ok can you now turn your attention to reviewing the code written by your fellow agents and checking for any issues, bugs, errors, problems, inefficiencies, security problems, reliability issues, etc. and carefully diagnose their underlying root causes using first-principle analysis and then fix or revise them if necessary?

Don't restrict yourself to the latest commits, cast a wider net and go super deep! Use ultrathink.

## Review Process

1. Check recent commits: `git log --oneline -20`
2. For each commit from other agents:
   - `git show <sha>` to see the changes
   - Trace the code paths affected
   - Look for integration issues with your own work
   - Check for violations of AGENTS.md rules
3. If you find issues:
   - Fix them directly
   - Notify the original agent via MCP Agent Mail
   - Update relevant beads
4. Run full verification:
   ```bash
   bun run typecheck
   bun run lint
   bun run test
   ```

## Common Issues to Watch For

- Inconsistent patterns across files
- Missing error boundaries
- Broken imports after refactoring
- Duplicate code that should be shared
- Race conditions in async code
- Memory leaks in effects/subscriptions
