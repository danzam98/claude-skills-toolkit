---
name: ntm-project-prep
description: Deep project orientation - read AGENTS.md and README.md thoroughly, then investigate the full codebase architecture before doing any work
version: 1.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "orientation", "context"]
---
# Project Preparation

Before touching a single line of code or claiming any task, you MUST complete all three steps below in full. There are no shortcuts.

---

## Step 1: Read AGENTS.md — Cover to Cover

Read the **entire** `AGENTS.md` file carefully. Do not skim. Internalize every section.

Pay special attention to:

1. **Rule Number 1** — NEVER delete any file without express written permission from the user. This is absolute.
2. **Irreversible Git & Filesystem Actions** — Forbidden commands, safer alternatives, mandatory explicit plan.
3. **Tech Stack** — Framework versions, package manager (Bun only — never npm/yarn), deployment target.
4. **Code Editing Discipline** — No code-mod scripts. No mass regex. Mechanical changes via parallel subagents only.
5. **Backwards Compatibility & File Sprawl** — No shims. No `componentV2.tsx`. Revise existing files in place.
6. **Design System** — Light mode primary. Color palette. Typography. Motion guidelines.
7. **Static Analysis & Type Safety** — Always run `bun run typecheck` and `bun run lint` after changes.
8. **Issue Tracking with br** — ALL task tracking goes through `br`. Never markdown TODOs. Always `--json` flag.
9. **Automatic Skill Triggers** — You MUST automatically invoke these skills when conditions are met. Memorize the trigger table.
10. **Workflow Loop** — Follow the bv → claim → implement → review → close → next loop exactly.
11. **Git Workflow** — Commit code AND `.beads/` together every time. `br sync --flush-only` before committing.
12. **Agent Communication Protocol** — Register with MCP Agent Mail. Check inbox. Notify peers.

---

## Step 2: Read README.md — Cover to Cover

Read the **entire** `README.md` file carefully. Understand:

- What the project is and who it's for
- The product goals and target audience
- Any setup, configuration, or deployment instructions
- Key features and how they fit together
- Any conventions, gotchas, or important notes documented there

---

## Step 3: Investigate the Codebase

Use your **Explore agent** subagent mode to deeply understand the architecture. Do not just skim the file tree — actually read key files and trace how things connect.

Investigate in this order:

### 3a. Project Structure
- Scan the top-level directory layout
- Understand `src/`, `functions/`, `content/`, `public/`, `.beads/` roles
- Note any unusual or non-standard directories

### 3b. Entry Points & Routing
- Read `src/app/layout.tsx` — root layout, fonts, metadata, providers
- Read `src/app/page.tsx` — homepage composition
- Scan `src/app/` for all routes and page files

### 3c. Design System & Tokens
- Read `src/app/globals.css` — all CSS custom properties, animation utilities
- Understand the color palette, spacing, shadow, and animation token system

### 3d. Core Components
- Read all files in `src/components/layout/` — header, footer, nav, containers
- Read all files in `src/components/home/` — hero, services, value props, etc.
- Read all files in `src/components/ui/` — button variants, cards, shared primitives
- Read all files in `src/components/islands/` — client-side interactive islands
- Read all files in `src/components/features/` — forms, calculators, affiliate CTAs

### 3e. Business Logic & Utilities
- Read all files in `src/lib/` — constants, utils, animations, search, github, env
- Read `content-collections.ts` — content schema definitions

### 3f. Backend & Integrations
- Read all files in `functions/` — Cloudflare Pages Functions (contact, newsletter, RUM, events)
- Understand the Turnstile CAPTCHA flow, rate limiting, and honeypot patterns

### 3g. Content Pipeline
- Scan `src/content/` — understand the MDX content structure (posts, guides, projects, etc.)
- Read a sample file from each content type to understand frontmatter conventions

### 3h. Build & Scripts
- Read all files in `scripts/` — GitHub enrichment, search index, RSS, image optimization
- Read `next.config.ts` — static export config, React compiler, typed routes

### 3i. Tests
- Scan `tests/` and any `__tests__/` directories
- Understand what's covered: unit tests, component tests, integration tests

---

## Step 4: Synthesize & Confirm Readiness

After completing all three steps, briefly summarize to yourself (internally):

- The project's purpose and key technical decisions
- The rules you must never violate (Rule #1, no deletion, bun only, br for tracking)
- The automatic skill triggers you must watch for
- Any open beads or in-progress work from `br ready --json`

Only then are you ready to claim a task and begin work.

---

## When to Use

- At the very start of a fresh agent session on this project
- When onboarding a new agent to the swarm for the first time
- Whenever an agent feels uncertain about project conventions or architecture
- After a long break or major architectural change

## Tips

- Use ultrathink throughout — this prep pays dividends for the entire session
- Do NOT rush Step 3. A thorough code investigation prevents mistakes that are expensive to fix
- If you find something undocumented or surprising, note it for later investigation
- This skill supersedes `ntm-start-agent` for initial orientation; use `ntm-start-agent` only if skipping the deep code investigation is acceptable
