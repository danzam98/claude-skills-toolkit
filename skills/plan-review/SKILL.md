# Plan Review

Review implementation plans with "fresh eyes" to catch errors, gaps, and bad assumptions before execution.

## What This Does

Systematic review of plan documents (from plan mode or written plans) looking for:
- Conceptual errors or logical violations
- Bad implicit assumptions
- Missing steps or dependencies
- Sloppy thinking or inaccurate information
- Edge cases not covered
- Risks not addressed

Can be run multiple times for iterative refinement until plan reaches "steady state".

## How to Use

- **After creating a plan:** `/plan-review` (reads current plan file)
- **Review specific plan:** `/plan-review <file-path>`
- **Multiple passes:** `/plan-review --passes 3` (run 3 times)

## Instructions

When this skill is invoked:

### Step 1: Read the Plan Document

- If in plan mode: Read the plan file specified in system message
- Otherwise: Ask user for plan file path or read most recent plan

### Step 2: Fresh Eyes Review Pass

Re-read the entire plan with fresh perspective, asking:

**Conceptual Questions:**
- Is the high-level approach sound?
- Are there logical contradictions?
- Does the plan actually solve the stated problem?

**Assumptions:**
- What implicit assumptions is this plan making?
- Are they valid? Could they be wrong?
- What happens if assumptions don't hold?

**Completeness:**
- Are all steps present from start to finish?
- Missing setup, configuration, or cleanup steps?
- What about error handling, rollback, monitoring?

**Dependencies:**
- Are dependencies between steps correctly identified?
- Any circular dependencies?
- External dependencies (APIs, services, data) accounted for?

**Risks:**
- What could go wrong?
- How will we detect failures?
- Is there a rollback/recovery plan?

**Verification:**
- How will we know if each step succeeded?
- How will we test the final result?
- Metrics or monitoring to track success?

### Step 3: Identify Issues

For each issue found, categorize:
- **CRITICAL:** Logical errors, missing essential steps, invalid assumptions
- **IMPORTANT:** Missing edge cases, unclear dependencies, risky operations
- **MINOR:** Unclear wording, optimization opportunities, documentation gaps

### Step 4: Fix Issues In-Place

Don't just report — fix the plan directly:
- Correct logical errors
- Add missing steps
- Clarify ambiguous sections
- Document assumptions explicitly
- Add verification steps
- Note risks and mitigation strategies

### Step 5: Report Changes

Summarize what was found and fixed:
- Number of issues by severity
- Key changes made to the plan
- Remaining risks or uncertainties
- Recommendation: Ready to execute? Need another pass?

### Multiple Passes

If user requests multiple passes (or issues found in first pass):
1. First pass: Catch obvious errors, logical issues
2. Second pass: Check assumptions, dependencies, edge cases
3. Third pass: Final verification, optimization, clarity

Continue until plan reaches "steady state" (no new issues found).

## Example Output

```
=== Plan Review Pass 1 ===

Read plan: /Users/danielai/.claude/projects/foo/plan.md

Issues found:

CRITICAL:
- Step 3 depends on database migration, but migration not created yet
  → Added "Create migration file" as new Step 2

- Assumption: "User records have email field" — not verified
  → Added verification step: Check schema before proceeding

IMPORTANT:
- No rollback plan if Step 5 fails
  → Added rollback procedure in Step 5 notes

- Missing verification for Step 4 (API integration)
  → Added "Test API with sample request" sub-step

MINOR:
- Step 6 wording unclear ("update the thing")
  → Clarified: "Update user.status field in database"

Changes applied to plan. Recommendation: Run one more pass to verify fixes.

Run another pass? (yes/no)
```

## Related Skills

- **/idea-wizard** — Generate ideas before planning
- **/fresh-eyes** — Review code (not plans)
