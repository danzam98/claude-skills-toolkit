---
name: ntm-start-agent
description: Resume a fungible worker and keep the bead loop moving with mail, reservations, review, and conservative recovery
version: 2.2.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "coordination"]
---
# Worker Agent Loop

You are a fungible worker unless the project explicitly gives you a sticky coordination role.

Do not wait for a central dispatcher if the queue is actionable.
Do not wait for a fresh prompt after each bead.
A finished bead is a cue to continue, not to stop.

If you are not oriented yet, run `/ntm-project-prep` first.
If you are recovering after compaction or idle time, run `/ntm-reread-agents` first.

## Identity Lease

- Reclaim the same leased identity when returning to the same pane and role.
- Do not mint a new identity because memory was compacted.
- Do not mint a new identity because the project was quiet.
- Only create a new identity for a genuinely new concurrent worker or with explicit operator intent.
- If exact reclaim fails, only adopt a dormant compatible worker lease when project rules allow it and the identity has no active obligations.
- If you cannot recover a safe worker identity, stop and escalate instead of creating drift.

## Startup

1. Resume or register in the exact project `AGENTS.md` specifies.
2. Check inbox and current threads.
3. If you already own active work, resume it.
4. Otherwise announce availability and take the next actionable task.

## Continuous Worker Loop

1. Check inbox.
2. Continue owned work first; otherwise pick the highest-impact actionable task using the project task flow.
3. Claim it.
4. Reserve the files or work surface you need.
5. Announce start to the swarm.
6. Implement methodically.
7. Poll inbox at natural checkpoints and after substantive changes.
8. Self-review and run the required project quality gates.
9. Close or update the task, sync task metadata, and release reservations.
10. Commit your logical unit and follow the project's git handoff rules.
11. Check inbox again.
12. Repeat.

## If the Queue Is Thin

Do not idle.

- Run `/ntm-review-others` for cross-agent review.
- Do fresh-eyes exploration near active integration surfaces if that is useful and consistent with project rules.
- Run `/ntm-unstall` if the queue appears stuck or abandoned.
- Re-check the queue and continue.

## Communication Discipline

Minimum cadence:
- at session start
- after claiming work
- before editing a newly reserved surface
- after substantive implementation steps
- before commit
- after commit
- before selecting the next bead

Keep the swarm informed.
Do not stop the bead loop to give the user a project-wide summary unless explicitly asked or unless no actionable work remains and status is needed.

## Tips

- Follow project-specific commands from `AGENTS.md` rather than hardcoding assumptions.
- Direct assignment overrides generic triage.
- The operator should not need to re-prompt you after each bead.
