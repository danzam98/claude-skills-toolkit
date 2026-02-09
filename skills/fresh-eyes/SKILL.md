# Fresh Eyes Review

Re-read all recently changed code with "fresh eyes" to catch bugs, errors, and bad assumptions before moving forward.

## What This Does

Systematically review all code that was just written or modified, looking for:
- Obvious bugs, errors, or logic issues
- Bad assumptions or edge cases missed
- Inconsistencies with existing code patterns
- Security vulnerabilities or performance issues
- Code that doesn't match the stated requirements

## How to Use

1. **After any code change:** Run automatically after writing/modifying code
2. **Multiple passes:** User can request 2-3 passes for extra scrutiny
3. **Before committing:** Final check before git commits

## Instructions

When this skill is invoked:

1. **Identify changed files** — Read git diff or ask user which files were modified
2. **Re-read each file completely** — Don't skim, read line by line with fresh perspective
3. **Look for problems:**
   - Logic errors, off-by-one errors, null pointer issues
   - Missing validation, error handling, or edge case coverage
   - Incorrect assumptions about data, state, or control flow
   - Security issues (SQL injection, XSS, auth bypass, etc.)
   - Performance problems (N+1 queries, unnecessary loops, etc.)
4. **Fix immediately** — Don't just report, fix what you find
5. **Report summary** — List what was found and fixed, with file:line references

## Number of Passes

- **Default:** 1 pass
- **User can request:** 2-3 passes for critical code or complex changes
- **Each pass:** Re-read with completely fresh perspective, as if seeing code for first time

## Example Usage

```
User: /fresh-eyes
You: Running fresh eyes review on recent changes...
     [reads git diff, identifies 3 files changed]
     [re-reads each file completely]

     Found and fixed:
     - auth.ts:42 — Missing null check on user object
     - api.ts:156 — SQL injection risk in raw query, switched to parameterized
     - utils.ts:89 — Off-by-one error in loop condition
```

## Related Skills

- **/bug-hunt** — More exploratory, investigates entire codebase
- **/peer-review** — Structured review like a senior developer would do
