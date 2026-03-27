---
name: ntm-start-agent
description: Start or resume a worker agent, register in the correct project, and keep looping through actionable work with strong communication discipline
version: 2.1.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "coordination"]
---
# Worker Agent Loop

Use this after orientation is complete.

If you have not already oriented yourself to the project, run `/ntm-project-prep` first.
If you are returning from compaction or a long idle period and only need rehydration, run `/ntm-reread-agents` first.

## Step 1: Reclaim the Correct Identity

If you are resuming the same pane/role after compaction or idle time, reuse the same agent identity.

Rules:
- do not mint a new identity just because memory was compacted
- do not mint a new identity just because the project was quiet
- only create a new identity for a genuinely new concurrent worker
- register or resume in the exact project AGENTS specifies
- if your original identity cannot be recovered, prefer a dormant unclaimed project identity that satisfies the idle-reuse threshold defined by AGENTS and has no active obligations over creating a brand-new one

## Step 2: Rejoin Swarm Coordination

Before taking work:
- register or resume in the correct project
- check inbox and respond to pending messages
- reconstruct your current assignment if you were already working something
- announce availability or resumed activity to the swarm

## Step 3: Enter the Continuous Worker Loop

Remain in this loop until there is no actionable work left, you are explicitly reassigned, or your role changes.

### Worker loop

1. Check inbox.
2. If you already own active work, continue that work first.
3. Otherwise pick the next actionable task using the project task-selection flow from AGENTS.
4. Claim the task using the project task tracker.
5. Reserve the files or surface you need before editing.
6. Announce start in the coordination channel.
7. Implement methodically.
8. Check inbox again at natural checkpoints and after substantive changes.
9. Self-review and run the project quality gates.
10. Close or update the task, sync task metadata, and release reservations.
11. Commit your logical unit and follow the project's git protocol.
12. Notify the git manager or follow the project's commit handoff rules.
13. Check inbox again.
14. Repeat.

## Step 4: If the Queue Appears Empty

If there is no actionable unclaimed work at the moment:
- check inbox again to see whether another agent needs help
- run `/ntm-review-others` to perform productive cross-agent review
- if the queue looks stuck, run `/ntm-unstall`
- re-check the queue after that

Do not stop just because one bead finished.
Do not stop to write a project-wide summary to the user unless explicitly asked, or unless no actionable work remains and the operator needs status.

## Communication Expectations

Minimum cadence:
- at session start
- after claiming work
- before editing a newly reserved file set
- after substantive implementation steps
- before commit
- after commit
- before selecting the next task

If you are heads-down for a long stretch, poll inbox anyway.

## When to Use

- at the start of a worker session after orientation
- after compaction once context is rehydrated
- when resuming a previously active worker

## Tips

- This is the main worker-loop skill. It should keep the agent moving without needing another prompt after each bead.
- If you are directly assigned a specific bead, continue the loop from that starting point instead of re-triaging.
- Follow project-specific commands from AGENTS rather than hardcoding assumptions into your behavior.
