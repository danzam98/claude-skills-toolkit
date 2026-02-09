# Peer Review

Review code as a senior developer would — structured feedback on bugs, style, security, and performance.

## What This Does

Structured code review (like a senior engineer reviewing a PR) covering:
- **Bugs & Logic:** Correctness, edge cases, error handling
- **Security:** Vulnerabilities, data exposure, auth issues
- **Performance:** Efficiency, scalability, resource usage
- **Style & Maintainability:** Readability, patterns, documentation
- **Testing:** Test coverage, test quality

Output is structured feedback with severity levels and actionable suggestions.

## How to Use

- **Review recent changes:** `/peer-review` (reviews git diff)
- **Review specific files:** `/peer-review <file-paths>`
- **Review PR:** `/peer-review --pr <number>` (uses gh CLI)
- **Focus area:** `/peer-review --security` or `--performance`

## Instructions

When this skill is invoked:

### Step 1: Identify Code to Review

- **Default:** Run `git diff` to see recent changes
- **Specific files:** Read the specified file paths
- **PR mode:** Use `gh pr diff <number>` to get PR changes
- **Focus area:** If specified, prioritize that aspect in review

### Step 2: Review Each Aspect

#### A. Bugs & Logic
- Are there logical errors, off-by-one errors, race conditions?
- Are edge cases handled (empty arrays, null values, boundary conditions)?
- Is error handling comprehensive (try/catch, error returns)?
- Are assumptions validated (type checks, null checks)?

#### B. Security
- **Input validation:** All user input sanitized and validated?
- **SQL injection:** Using parameterized queries, not string concatenation?
- **XSS:** Output properly escaped for HTML context?
- **Auth/authz:** Proper authentication and authorization checks?
- **Data exposure:** Sensitive data (passwords, tokens) not logged or exposed?
- **CSRF:** State-changing operations protected?

#### C. Performance
- **Database:** N+1 queries? Missing indexes? Unnecessary queries?
- **Algorithms:** Efficient complexity (avoid O(n²) if possible)?
- **Caching:** Opportunities to cache expensive operations?
- **Memory:** Leaks, unbounded arrays, large object retention?
- **Network:** Unnecessary API calls, missing pagination?

#### D. Style & Maintainability
- **Readability:** Clear variable names, logical structure, appropriate comments?
- **Patterns:** Follows existing codebase patterns and conventions?
- **DRY:** Code duplication that should be extracted?
- **Complexity:** Functions too long or complex (>50 lines, >3 levels deep)?
- **Documentation:** Complex logic explained, public APIs documented?

#### E. Testing
- **Coverage:** Are critical paths tested?
- **Quality:** Tests actually verify behavior, not just pass?
- **Edge cases:** Tests cover error paths, edge cases, boundary conditions?
- **Maintainability:** Tests are clear, not brittle, easy to understand?

### Step 3: Categorize Findings

For each issue, assign severity:
- **BLOCKING:** Must fix before merge (security holes, crashes, data loss)
- **HIGH:** Should fix before merge (bugs, performance issues)
- **MEDIUM:** Fix soon (code smells, missing tests, minor inefficiencies)
- **LOW:** Consider fixing (style, documentation, nitpicks)

### Step 4: Provide Actionable Feedback

For each finding:
- **Location:** File and line number (e.g., `auth.ts:42`)
- **Issue:** What's wrong
- **Impact:** Why it matters
- **Suggestion:** How to fix it (with code example if helpful)

### Step 5: Summary & Recommendation

- Count of issues by severity
- Overall assessment: APPROVE / REQUEST CHANGES / COMMENT
- Highlight most critical issues to address first
- Offer to fix issues automatically

## Example Output

```
=== Peer Review: auth-refactor branch ===

Reviewed 4 files, 312 lines changed

BLOCKING:
- auth/login.ts:67 — SQL injection vulnerability
  Impact: Attacker can dump entire database
  Fix: Replace string interpolation with parameterized query
  ```typescript
  // Before
  db.query(`SELECT * FROM users WHERE email = '${email}'`)

  // After
  db.query('SELECT * FROM users WHERE email = ?', [email])
  ```

HIGH:
- auth/session.ts:123 — Race condition in session creation
  Impact: Concurrent logins can create duplicate sessions
  Fix: Use database transaction or unique constraint

- api/users.ts:89 — Missing authentication check
  Impact: Unauthenticated users can access user list
  Fix: Add auth middleware before handler

MEDIUM:
- auth/login.ts:45 — No test for failed login attempt
  Impact: Error path not verified, could break without detection
  Fix: Add test case for wrong password scenario

- utils/hash.ts:34 — Using deprecated crypto function
  Impact: May break in future Node.js versions
  Fix: Update to `crypto.scrypt` (modern alternative)

LOW:
- auth/types.ts:12 — Missing JSDoc for User interface
  Impact: Other devs need to read code to understand fields
  Fix: Add JSDoc comment explaining each field

Summary: 1 blocking, 2 high, 2 medium, 1 low

RECOMMENDATION: REQUEST CHANGES
Priority: Fix the SQL injection (BLOCKING) and add auth check (HIGH)

Should I fix the blocking and high-severity issues now? (yes/no/specific)
```

## Related Skills

- **/fresh-eyes** — Lighter-weight review of recent changes
- **/bug-hunt** — Exploratory investigation of codebase
