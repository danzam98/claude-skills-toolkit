# AGENTS.md — AI Agent Rules for [PROJECT NAME]

<!--
  TEMPLATE INSTRUCTIONS
  =====================
  This file is the authoritative source of truth for all AI agents working on this project.
  Agents read this file at the start of every session before doing any work.

  HOW TO USE THIS TEMPLATE:
  1. Replace all [TODO: ...] placeholders with your project-specific content
  2. Remove placeholder comments (<!-- ... --> blocks) as you fill them in
  3. Delete any sections that don't apply to your project
  4. Keep all the universal rules verbatim — they apply to every project
  5. Add project-specific sections below the Quick Reference as needed

  The rule of thumb: AGENTS.md encodes project specifics.
  Skills encode workflow and reasoning. Never put project-specific content in skills.
-->

---

## Project Overview

<!-- [TODO: 2-4 sentences describing what this project is, who it's for, and what it does.] -->

[PROJECT NAME] is a [DESCRIPTION] that [PURPOSE].

Key concepts:
- **[Concept 1]** — [Description]
- **[Concept 2]** — [Description]
- **[Concept 3]** — [Description]

**Reference:** `docs/IMPLEMENTATION_PLAN.md` <!-- [TODO: update or remove] -->

---

## ⚠️ Current Development Phase: [PHASE NAME]

<!-- [TODO: Describe the current phase and what agents should and should not do.
     Example: "We are building HTML mockups. Do NOT create React components yet."
     Delete this section if your project has no phase restrictions.] -->

**We are currently in [PHASE NAME].**

Do NOT:
- [Restriction 1]
- [Restriction 2]

All work should be in `[DIRECTORY]` using [TECH STACK].

---

## Project Structure

<!-- [TODO: Describe the top-level directory layout and the role of each directory.
     Agents use this to orient themselves — be specific and accurate.] -->

```
[PROJECT ROOT]/
├── [dir1]/          # [Purpose]
├── [dir2]/          # [Purpose]
├── [dir3]/          # [Purpose]
├── .beads/          # Beads task tracking (always commit alongside code)
├── AGENTS.md        # This file
└── README.md        # Human-facing project documentation
```

---

## RULE NUMBER 1 (NEVER EVER EVER FORGET THIS RULE!!!)

**YOU ARE NEVER ALLOWED TO DELETE A FILE WITHOUT EXPRESS PERMISSION FROM ME OR A DIRECT COMMAND FROM ME.**

Even a new file that you yourself created, such as a test code file. You must **ALWAYS** ask and *receive* clear, written permission before deleting any file or folder.

---

## IRREVERSIBLE GIT & FILESYSTEM ACTIONS — DO-NOT-EVER BREAK GLASS

1. **Absolutely forbidden commands:** `git reset --hard`, `git clean -fd`, `rm -rf`, or any command that can delete or overwrite code/data must never be run unless the user explicitly provides the exact command and states they understand the consequences.

2. **No guessing:** If there is any uncertainty about what a command might delete or overwrite, stop immediately and ask.

3. **Safer alternatives first:** Use non-destructive options (`git status`, `git diff`, `git stash`, backups) before considering destructive commands.

4. **Mandatory explicit plan:** Even after authorization, restate the command verbatim, list exactly what will be affected, and wait for confirmation.

---

## Code Editing Discipline

**NEVER** run scripts that auto-process/change multiple code files. No invented code mods, no giant regex `sed` one-liners.

- **Mechanical changes**: Use subagents in parallel, but apply edits **manually** and review diffs.
- **Complex changes**: Do them methodically, file by file.

---

## File Organization — Avoid Sprawl

Do **NOT** create duplicate or versioned files:
- ❌ `componentV2.tsx`, `componentImproved.tsx`, `componentNew.tsx`
- ✅ Revise the **existing** file in place

New files are reserved for **genuinely new domains** that don't fit existing modules.

---

## Tech Stack

<!-- [TODO: Fill in the tech stack. Use separate tables if you have multiple environments
     (e.g., dev/mockup vs. production, frontend vs. backend).] -->

| Package | Version | Notes |
|---------|---------|-------|
| [Framework] | [x.x] | [Purpose] |
| [Language] | [x.x] | [Notes] |
| [Package manager] | [x.x] | **Use this — never alternatives** |
| [Build tool] | [x.x] | [Notes] |
| [Test framework] | [x.x] | [Notes] |

---

## Static Analysis — Mandatory Before Commits

<!-- [TODO: Fill in the exact commands to run before committing.
     These are what ntm-review-own, ntm-review-others, ntm-commit-all,
     and ntm-git-manager will use.] -->

```bash
# [TODO: Replace with your actual check commands]
[package-manager] run typecheck   # Type checking
[package-manager] run lint        # Linting
[package-manager] run build       # Build verification
[package-manager] run test        # Tests (if applicable)
```

If there are errors:
1. Read context around each error to understand the root cause
2. Fix at root cause — do not silence rules
3. Re-run until clean
4. **Do not commit with failing checks**

---

## Design System

<!-- [TODO: Fill in your project's colors, fonts, and design tokens.
     Agents (especially ntm-ui-polish) reference this section.
     Delete this section if the project has no UI.] -->

### Brand Colors

```css
/* [TODO: Replace with your actual design tokens] */
@theme {
  --color-primary:    #[hex];   /* [Name] */
  --color-secondary:  #[hex];   /* [Name] */
  --color-accent:     #[hex];   /* [Name] */
  --color-background: #[hex];   /* [Name] */
}
```

### Typography

<!-- [TODO: Fonts, scale, and any typographic conventions] -->

---

## Git Workflow — CRITICAL

### NOTIFY THE GIT MANAGER AFTER EVERY COMMIT

**NEVER leave commits without notifying the git manager.** After EVERY commit, immediately notify the dedicated git manager agent via MCP Agent Mail so it can handle the remote push.

**Do NOT run `git push` yourself.** Remote pushes are the git manager's sole responsibility.

### Branch Strategy

| Branch | Purpose | Who Can Push |
|--------|---------|--------------|
| `main` | Production-ready code | Via PR only (preferred) |
| `feat/*` | Feature development | Agent directly |
| `fix/*` | Bug fixes | Agent directly |

**Preferred workflow for significant changes:**
```bash
git checkout -b feat/my-feature
# ... make changes ...
git commit -m "feat: description"
# Notify git manager — it handles push and PR creation
```

### Before Starting Work

```bash
git fetch origin
git status                    # Check for uncommitted changes
git pull --rebase origin main # Get latest changes
```

### Standard Workflow

1. **Pull latest** from remote
2. **Make changes** (one logical unit at a time)
3. **Run checks** — use the commands from the Static Analysis section above
4. **Commit** with descriptive message
5. **Notify git manager** — do NOT run `git push` yourself

### After Every Change Session

```bash
git status                    # Verify nothing uncommitted
git log origin/main..HEAD     # Check what's unsynced — notify git manager if anything
```

### Commit Messages

Use conventional commits:
- `feat:` — New feature
- `fix:` — Bug fix
- `docs:` — Documentation
- `refactor:` — Code restructuring
- `test:` — Tests
- `chore:` — Maintenance

### NEVER DO THESE

| Forbidden Action | Why | Alternative |
|-----------------|-----|-------------|
| `git push --force` to main | Destroys shared history | Create a new commit to fix |
| `git reset --hard` | Loses uncommitted work | `git stash` or commit first |
| Run `git push` yourself | Conflicts with git manager | Notify git manager instead |
| Ignore CI failures | Breaks the build | Fix immediately |
| Commit secrets | Security breach | Use `.env.local` (gitignored) |
| Amend pushed commits | Rewrites shared history | Create a new fix commit |

---

## Agent CLI (`./robot`)

This project includes a `./robot` CLI at the project root, optimized for agent use. It provides JSON output, structured errors, and meaningful exit codes.

**All agents should use `./robot` as the primary interface.** If `./robot` is missing (e.g., fresh clone), run `/robot-mode-maker` to create it before starting any work.

```bash
./robot help --json      # Full command reference
./robot status --json    # Git + beads + scaffold health in one call
./robot next --json      # Top actionable bead
./robot triage --json    # Full dependency-ranked queue
./robot claim <id>       # Set bead in_progress
./robot done <id>        # Close bead + flush .beads/
./robot build            # Run project build
./robot files [query]    # Find source files (fuzzy)
./robot sync             # br sync --flush-only + stage .beads/
```

---

## Domain-Specific Patterns

<!-- [TODO: Document the architectural patterns agents must follow in this project.
     Examples: 3-column CRM layout, multi-step wizard pattern, API response shape, etc.
     Delete this section if not needed, or replace with your own patterns.] -->

### [Pattern Name]

[Description and example code]

---

## Route / Module Structure

<!-- [TODO: Document the URL routes (for web apps) or module layout (for libraries/CLIs).
     This helps agents understand where to create new files.] -->

### [Section 1] (`/path/`)

```
[route or module tree]
```

---

## Implementation Phases

<!-- [TODO: If your project has defined phases, document them here.
     This tells agents what's in scope for the current phase.
     Delete this section if your project doesn't use phases.] -->

### Phase 0: [Name]
- [Task 1]
- [Task 2]

### Phase 1: [Name]
- [Task 1]
- [Task 2]

---

## Accessibility

- WCAG 2.2 AA baseline
- All interactive elements need visible focus states
- Skip link at top of page
- Meaningful alt text for images
- Respect `prefers-reduced-motion`
- Proper heading hierarchy

---

## Performance Targets

<!-- [TODO: Fill in your project's performance targets, or delete this section.] -->

- LCP < [X]s (p75)
- INP < [X]ms (p75)
- CLS < [X]
- JS bundle < [X]KB gzip

---

## Best Practices Reference

<!-- [TODO: List any best-practice documents in your repo that agents should consult.] -->

See `best-practices/` folder:
- `[framework].md` — [Framework-specific patterns]
- `[topic].md` — [Topic-specific guidelines]

---

## Quick Reference

<!-- [TODO: Fill in the actual shell commands for this project.
     This is what agents use day-to-day — make it accurate.] -->

```bash
# Development
[package-manager] dev        # Start dev server
[package-manager] build      # Build for production
[package-manager] test       # Run tests

# Git
git status                   # Check state
git add <files>              # Stage specific files
git commit -m "..."          # Commit, then notify git manager

# Agent CLI
./robot status --json        # Project health snapshot
./robot next --json          # Next task to work on
```

<!-- bv-agent-instructions-v2 -->

---

## Beads Workflow Integration

This project uses [beads_rust](https://github.com/Dicklesworthstone/beads_rust) (`br`) for issue tracking and [beads_viewer](https://github.com/Dicklesworthstone/beads_viewer) (`bv`) for graph-aware triage. Issues are stored in `.beads/` and tracked in git.

**Note:** `br` is non-invasive and never executes git commands. After `br sync --flush-only`, you must manually run `git add .beads/` and `git commit`.

### Using bv as an AI sidecar

bv is a graph-aware triage engine. Use robot flags for deterministic, dependency-aware outputs with precomputed metrics (PageRank, betweenness, critical path, cycles, HITS, eigenvector, k-core).

**CRITICAL: Use ONLY `--robot-*` flags. Bare `bv` launches an interactive TUI that blocks your session.**

```bash
bv --robot-triage        # THE MEGA-COMMAND: start here
bv --robot-next          # Minimal: just the single top pick + claim command
bv --robot-triage --format toon  # Token-optimized output
```

### br Commands for Issue Management

```bash
br ready              # Show issues ready to work (no blockers)
br list --status=open # All open issues
br show <id>          # Full issue details with dependencies
br create --title="..." --type=task --priority=2
br update <id> --status=in_progress
br close <id> --reason="Completed"
br sync --flush-only  # Export DB to JSONL
git add .beads/       # Stage beads changes
git commit -m "sync beads"
```

### Workflow Pattern

1. **Triage**: `./robot triage` (or `bv --robot-triage`) — find highest-impact actionable work
2. **Claim**: `./robot claim <id>` (or `br update <id> --status=in_progress`)
3. **Work**: Implement the task
4. **Complete**: `./robot done <id>` (or `br close <id>` + `br sync --flush-only`)
5. **Commit**: Always run `./robot sync` then commit code and `.beads/` together
6. **Notify**: Tell the git manager to push

### Session Protocol

```bash
git status              # Check what changed
git add <files>         # Stage code changes
./robot sync            # Flush beads + stage .beads/
git commit -m "..."     # Commit everything together
# Notify git manager — it handles the remote push
```

<!-- end-bv-agent-instructions -->
