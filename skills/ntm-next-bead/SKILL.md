---
name: ntm-next-bead
description: Re-enter the worker loop by checking coordination state, picking the next actionable task, and continuing without waiting for operator intervention
version: 2.2.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "beads", "workflow"]
---
# Continue to Next Task

Use this when you are already oriented and need to get moving again.

If you are returning from compaction or a long idle period and have not reconstructed state yet, run `/ntm-reread-agents` first.

## Re-entry Rules

- You are still the same fungible worker unless the project explicitly changed your role.
- Reuse the same identity lease; do not create a new one just because context was lost.
- If you already own active work, continue it instead of picking something new.
- If mail or the operator directly assigns you a task, follow that instead of generic triage.

## Re-entry Loop

1. Check inbox and active threads.
2. Confirm whether you already own active work.
3. If not, select the next actionable task using the project task flow from `AGENTS.md`.
4. Claim it.
5. Reserve the required files or work surface.
6. Announce start.
7. Implement, polling inbox at natural checkpoints.
8. Self-review and run the required quality gates.
9. Close or update the task, sync task metadata, release reservations, and follow the project's commit handoff rules.
10. Check inbox again.
11. Continue the worker loop.

## If Nothing Is Actionable

- Run `/ntm-review-others`, or
- Run `/ntm-unstall` if the queue appears blocked or abandoned,
- Then re-check the queue.

Do not stop just to summarize the project to the user unless explicitly asked or unless no actionable work remains.
