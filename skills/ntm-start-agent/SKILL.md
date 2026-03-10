---
name: ntm-start-agent
description: Initialize a worker agent with full project context and coordination protocols
version: 2.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "coordination"]
---
# Agent Startup Instructions

Read ALL of AGENTS.md super carefully before doing anything else. Pay special attention to:

1. **Rule Number 1** — NEVER delete files without explicit permission
2. **Automatic Skill Triggers** — You MUST follow these triggers automatically
3. **Git Workflow** — Do NOT push yourself; notify the git manager after committing
4. **Tech Stack & Check Commands** — Note the exact commands for this project; do not assume

Then use your code investigation agent mode to understand the codebase architecture.

## Required Setup

1. **Check for `./robot`** — if it doesn't exist, run `/robot-mode-maker` first
2. **Get project health snapshot**: `./robot status --json` (or `bv --robot-triage` fallback)
3. **Register with MCP Agent Mail** — introduce yourself to other agents
4. **Check your inbox** and respond to any pending messages

## Starting Work

1. Find priority work: `./robot next --json` (or `bv --robot-next`)
2. Claim the bead: `./robot claim <id>` (or `br update <id> --status in_progress`)
3. Notify agents via MCP Agent Mail what you're working on
4. Implement the task systematically — comply with AGENTS.md and best practice guides
5. Before closing: run `/ntm-review-own` to catch bugs with fresh eyes
6. Close and sync: `./robot done <id>` (or `br close <id>` + `br sync --flush-only`)
7. Commit code and `.beads/` together; notify the git manager — do NOT push yourself
8. Loop: run `/ntm-next-bead`

Don't get stuck in "communication purgatory" — be proactive about starting tasks, but always mark beads and inform fellow agents.

Use ultrathink.

## Required Tools

- **MCP Agent Mail** — inter-agent coordination
- **`./robot`** — standardized project operations (status, next, claim, done, build, files)
- **`bv`** (beads_viewer) — priority-based task selection (fallback if `./robot` unavailable)
- **`br`** (beads_rust) — issue and task tracking

## When to Use

- At the start of a new worker agent session
- When spawning worker agents in an NTM swarm
- To get agents oriented and productive quickly

## Tips

- Send to worker agents only — not the git manager (use `/ntm-git-manager` for that)
- Always claim beads before starting to prevent duplicate work
- All coordination happens through MCP Agent Mail
