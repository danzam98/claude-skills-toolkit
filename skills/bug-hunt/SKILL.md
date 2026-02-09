# Bug Hunt

Systematically explore the codebase to find bugs, inefficiencies, security issues, and reliability problems.

## What This Does

Unlike focused code review, bug hunting is **exploratory investigation**:
- Randomly explore code files to find hidden issues
- Trace execution flows through the system
- Look for bugs, inefficiencies, security holes, reliability problems
- Check error handling paths and edge cases
- Report findings with severity, location, and suggested fixes

## How to Use

1. **General investigation:** `/bug-hunt` — explore entire codebase
2. **Focused hunt:** `/bug-hunt <directory>` — target specific area
3. **Security focus:** `/bug-hunt --security` — prioritize security issues
4. **Performance focus:** `/bug-hunt --performance` — find inefficiencies

## Instructions

When this skill is invoked:

1. **Random exploration** — Pick 5-10 files semi-randomly:
   - Critical paths (auth, payment, data processing)
   - Recently changed files (more likely to have new bugs)
   - Complex files with high cyclomatic complexity
   - Files with many dependencies

2. **Trace execution flows:**
   - Follow function calls from entry points
   - Check error handling at each step
   - Verify assumptions about data and state
   - Look for edge cases that break logic

3. **Look for common issues:**
   - **Bugs:** Logic errors, race conditions, null/undefined handling, off-by-one errors
   - **Security:** SQL injection, XSS, CSRF, auth bypass, sensitive data exposure
   - **Performance:** N+1 queries, unnecessary loops, missing indexes, memory leaks
   - **Reliability:** Missing error handling, unvalidated input, bad assumptions

4. **Report findings:**
   - **HIGH severity:** Security vulnerabilities, data loss risks, crashes
   - **MEDIUM severity:** Logic bugs, performance issues, reliability problems
   - **LOW severity:** Code smells, minor inefficiencies, style issues

   For each finding:
   - File and line number (e.g., `auth.ts:42`)
   - Description of the issue
   - Why it's a problem (impact)
   - Suggested fix

5. **Offer to fix** — Ask user which issues to fix immediately

## Example Output

```
=== Bug Hunt Report ===

HIGH SEVERITY:
- auth/login.ts:156 — SQL injection in raw query
  Impact: Attacker can dump database
  Fix: Use parameterized query with prepared statement

- api/payments.ts:89 — Missing authentication check
  Impact: Unauthenticated users can process payments
  Fix: Add auth middleware before handler

MEDIUM SEVERITY:
- users/profile.ts:234 — N+1 query in loop
  Impact: 100+ users = 100+ database queries, slow page load
  Fix: Use eager loading or single query with JOIN

- utils/parser.ts:67 — Unhandled exception in JSON.parse
  Impact: Crashes server on malformed input
  Fix: Wrap in try/catch, return error response

LOW SEVERITY:
- components/Header.tsx:34 — Unused import
  Impact: Slightly larger bundle size
  Fix: Remove unused import

Which issues should I fix? (all/high/specific)
```

## Related Skills

- **/fresh-eyes** — Review recent changes, not exploratory
- **/peer-review** — Structured review of specific code/PR
