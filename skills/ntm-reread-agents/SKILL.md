---
name: ntm-reread-agents
description: Recover cleanly after compaction by reclaiming the same identity lease, re-reading authority surfaces, and reconstructing current work before resuming
version: 2.2.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "context", "refresh"]
---
# Rehydrate After Compaction

Use this after memory compaction or after returning from a long idle period when you need to reconstruct state without creating identity drift.

## Recovery Order

1. Reclaim the same identity lease for the same pane and role.
2. Re-read `AGENTS.md` fully.
3. Follow AGENTS' authority order and re-read the project surfaces it names.
4. Reconstruct inbox state, active threads, reservations, current queue state, and any work or sticky role you already own.
5. Resume the correct loop: worker, git manager, or queue recovery.

## Identity Lease Rules

- Do not register a fresh identity just because memory was compacted.
- Do not register a fresh identity just because the project was quiet.
- If you do not remember your identity, recover it from the coordination system before acting.
- If exact reclaim fails, only adopt a dormant compatible identity lease when project rules allow it and the identity has no active obligations.
- If you cannot safely reclaim or adopt a compatible lease, stop and escalate instead of creating a new agent footprint.

## Resume Rules

- If you already own active work, resume it.
- If you are the git manager, return to the git-manager loop.
- If you are a worker with no active task, return to the worker loop or use `/ntm-next-bead`.
- If there is no actionable work, use `/ntm-review-others` or `/ntm-unstall`, then re-check.

Do not stop to write a user-facing project summary unless explicitly asked or unless no actionable work remains and status is required.
