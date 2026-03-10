---
name: ntm-bug-hunt
description: Random codebase exploration to find and fix lurking bugs
version: 2.0.0
author: Daniel Fischer
category: debugging
tags: ["ntm", "multi-agent", "swarm", "debugging", "exploration"]
---
# Random Code Exploration and Bug Hunt

Randomly explore source files in this project, deeply investigate their functionality and execution flows, then find and fix bugs with fresh eyes. Be systematic, methodical, and critical. Use ultrathink.

Comply with ALL rules in AGENTS.md. Ensure any code you write or revise conforms to the best practice guides referenced in AGENTS.md.

## Exploration Strategy

### 1. Discover files to explore

Use `./robot files` if available — it finds source files appropriate for this project automatically:

```bash
# Preferred:
./robot files --json

# Fallback — find source files in the directories AGENTS.md describes:
# Check AGENTS.md Project Structure section for the right directories,
# then list files within them. Do NOT assume src/, app/, or any specific path.
```

Pick 3–5 files at random to start, spread across different areas.

### 2. For each file

- Read it completely
- Trace imports or includes upstream — understand what it depends on
- Trace exports or usages downstream — understand what depends on it
- Map the full data and control flow
- Understand the file's purpose in the larger application context

### 3. Apply fresh-eyes inspection

Look for:
- Logic errors and off-by-one mistakes
- Unreachable branches or dead code
- Missing null/undefined/empty checks
- Incorrect assumptions about data shape
- Hardcoded values that should be configurable
- Missing error handling or graceful degradation
- Security issues (XSS, injection, exposed secrets)
- Accessibility violations (missing labels, focus traps, contrast)
- Performance issues (unnecessary re-renders, blocking operations, N+1 patterns)
- TODO/FIXME comments that were never addressed
- Violations of AGENTS.md rules or project conventions

### 4. Fix what you find

Fix issues directly and carefully. Do not introduce new patterns — match existing conventions in the codebase. For each fix, understand the root cause first.

### 5. Verify with project check commands

After fixes, run the check commands from AGENTS.md's Quick Reference (build, typecheck, lint — whatever applies to this project). Fix any errors. Repeat until clean.

### 6. Report and continue

After fixing, notify fellow agents via MCP Agent Mail of what you found and fixed. Then pick another set of files and repeat.

---

## When to Use

- When agents are idle between tasks
- As a general code quality sweep
- When lurking bugs are suspected

## Tips

- Spread coverage — don't re-explore files you've already reviewed this session
- Fixes should always be committed via the git manager
- Great for keeping agents productively busy between bead tasks
