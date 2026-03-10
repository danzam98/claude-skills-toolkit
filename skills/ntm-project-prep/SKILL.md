---
name: ntm-project-prep
description: Deep project orientation - read AGENTS.md and README.md thoroughly, then investigate the full codebase architecture before doing any work
version: 2.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "orientation", "context"]
---
# Project Preparation

Before touching a single line of code or claiming any task, complete every step below in full. No shortcuts. Use ultrathink throughout.

---

## Step 0: Ensure `./robot` CLI Exists

Check for the project-level agent CLI before anything else:

```bash
ls ./robot 2>/dev/null && echo "exists" || echo "missing"
```

If missing, invoke `/robot-mode-maker` to create it. The `./robot` CLI provides machine-readable status, file discovery, bead operations, and build execution — later steps depend on it.

---

## Step 1: Read AGENTS.md — Cover to Cover

Read the **entire** `AGENTS.md` file. Do not skim. Internalize every section.

Pay special attention to:

1. **Rule Number 1** — NEVER delete any file without express written permission. This is absolute.
2. **Irreversible Git & Filesystem Actions** — Forbidden commands, safer alternatives, mandatory explicit plan.
3. **Tech Stack** — Framework versions, package manager, deployment target. Note exactly what AGENTS.md specifies — do not assume bun, npm, or any particular framework.
4. **Code Editing Discipline** — No code-mod scripts. No mass regex. Mechanical changes via parallel subagents only.
5. **File Organization** — No duplicate or versioned files. No `componentV2`, no shims. Revise existing files in place.
6. **Design System** — Color palette, typography, and any motion or accessibility guidelines specific to this project.
7. **Static Analysis** — Note the exact check commands in AGENTS.md's Quick Reference. These vary by project and by development phase — do not assume `bun`, `npm`, or specific command names.
8. **Issue Tracking** — ALL task tracking goes through `br`. Never use markdown TODOs.
9. **Automatic Skill Triggers** — If a trigger table exists, memorize it. You MUST invoke triggered skills automatically.
10. **Workflow Loop** — Follow the triage → claim → implement → review → close → next loop exactly.
11. **Git Workflow** — Commit code AND `.beads/` together. Do NOT run `git push` yourself — notify the git manager.
12. **Agent Communication** — Register with MCP Agent Mail. Check inbox. Notify peers of what you're working on.

---

## Step 2: Read README.md — Cover to Cover

Read the **entire** `README.md`. Understand:

- What the project is and who it's for
- Product goals and target audience
- Setup, configuration, or deployment instructions
- Key features and how they fit together
- Any conventions, gotchas, or important notes

---

## Step 3: Get Project Health Snapshot

```bash
./robot status --json
```

Note: current git branch, uncommitted files, bead counts (open/actionable/in-progress), and scaffold state. This tells you exactly where the project stands before you explore code.

---

## Step 4: Investigate the Codebase

Use your Explore agent subagent mode. **Base your exploration entirely on what AGENTS.md describes as the project structure** — do not assume Next.js, Rails, HTML, or any particular layout. Read the directories and files that AGENTS.md points to.

### 4a. Project Structure
- Scan the top-level directory layout
- Map each major directory to the role AGENTS.md describes for it
- Note anything unusual, missing, or not yet scaffolded

### 4b. Entry Points
- Find the main entry points for the project (could be HTML files, app entry files, API routes, index files — whatever this project uses)
- Understand how the application starts and how pages or routes are organized

### 4c. Design System & Tokens
- Find the primary styling files (CSS, design token files, theme configs)
- Understand the color palette, spacing, and any utility or token conventions
- Note the design values from AGENTS.md Brand Colors section

### 4d. Shared Components / Templates
- Explore shared layout components, templates, or partials described in AGENTS.md
- Read navigation, header, footer, and any layout wrappers
- Understand shared UI primitives or component patterns

### 4e. Data & Business Logic
- Find seed data, fixtures, content files, or API schemas
- Read key utility or shared library files
- Understand data shapes and how they flow through the application

### 4f. Build & Configuration
- Read build config files referenced in AGENTS.md (package.json, vite.config, next.config, etc.)
- Understand the dev/build/preview/test commands — these are your check commands
- Note environment variables or configuration requirements

### 4g. Tests (if present)
- Check whether a test directory exists
- Understand what's covered and what tooling is used
- If no tests exist, note that for later

---

## Step 5: Synthesize & Confirm Readiness

Internally summarize before picking up any work:

- The project's purpose and key technical decisions
- Rules you must never violate: Rule #1 (no deletion), correct package manager, `br` for tracking, no self-push
- The exact check commands for this project (from AGENTS.md Quick Reference)
- Whether `./robot` exists and what commands it exposes (`./robot help --json`)
- Current bead state: `./robot triage --json` (or `bv --robot-triage` as fallback)

Only then are you ready to claim a task and begin work.

---

## When to Use

- At the very start of a fresh agent session
- When onboarding a new agent to the swarm for the first time
- Whenever an agent feels uncertain about project conventions or architecture
- After a long break or major architectural change

## Tips

- Use ultrathink throughout — this prep pays dividends for the entire session
- Do NOT rush Step 4. A thorough investigation prevents mistakes that are expensive to fix
- AGENTS.md is the authoritative source; if README.md conflicts with it, AGENTS.md wins
- If you find something undocumented or surprising, note it before continuing
- This skill supersedes `ntm-start-agent` for initial orientation
