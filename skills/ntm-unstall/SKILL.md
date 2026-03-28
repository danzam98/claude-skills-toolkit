---
name: ntm-unstall
description: Recover a stalled swarm queue by conservatively reopening abandoned work and returning fungible workers to productive motion
version: 2.2.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "beads", "recovery", "stalled"]
---
# Recover a Stalled Queue

Any fungible worker can perform conservative queue recovery when the swarm appears stuck.

If you are returning from compaction or a long idle period and have not reconstructed state yet, run `/ntm-reread-agents` first.

## Recovery Rules

- Check coordination state before touching the queue.
- Never reset a live agent's work just because it looks quiet.
- Reopen only confirmed abandoned work.
- Leave a visible reason in task history and in swarm communication.

## Recovery Loop

1. Check inbox and recent coordination messages.
2. Inspect current in-progress work and reservations.
3. Identify tasks that look abandoned according to the project's task tracker and activity signals.
4. Reopen or reset only the tasks you can justify as abandoned.
5. Notify the swarm about what you recovered and why.
6. Re-run the project's triage flow.
7. Claim the highest-impact actionable task if appropriate, reserve files, announce start, and return to the worker loop.

If there is still no actionable work after recovery, run `/ntm-review-others` and continue monitoring.
Do not stop to produce a user-facing project summary unless explicitly asked or unless no actionable work remains and status is required.
