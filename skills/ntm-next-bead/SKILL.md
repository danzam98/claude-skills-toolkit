---
name: ntm-next-bead
description: Re-enter the worker loop by picking, claiming, and starting the next actionable task using the project's task-selection flow
version: 2.1.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "beads", "workflow"]
---
# Continue to Next Task

Use this when you are already oriented and need to resume productive task pickup.

If you are returning from compaction and have not rehydrated context yet, run `/ntm-reread-agents` first.

## Step 1: Check Coordination State

Before selecting work:
- check inbox
- confirm whether you already own an active task
- respond to anything blocking or relevant

If you already own active work, continue it instead of picking something new.

## Step 2: Select and Claim the Next Actionable Task

Use the project's task-selection flow from AGENTS.

Rules:
- prefer the project's machine-readable task selector if it exists
- otherwise use the project task tracker commands AGENTS specifies
- claim before starting
- avoid racing other agents by communicating promptly once claimed

## Step 3: Reserve and Announce

Before editing:
- reserve the required files or work surface
- announce start to the swarm
- reference the task id in reservation reasons and message subjects where the project expects that

## Step 4: Implement and Communicate

Implement systematically.

During execution:
- check inbox at natural checkpoints
- send brief progress notes when the task meaningfully advances, blocks, or changes direction
- keep the swarm aware of anything that affects other agents

## Step 5: Close Cleanly and Continue

After finishing:
- self-review
- run the project quality gates
- close or update the task in the project tracker
- sync task metadata
- release reservations
- commit your logical unit and follow the project's git protocol
- notify the git manager or follow the project's commit handoff rules
- check inbox again

Then continue the worker loop.

## Step 6: If Nothing Is Actionable

If there is no actionable work right now:
- run `/ntm-review-others`, or
- run `/ntm-unstall` if the queue appears blocked or abandoned
- then re-check the queue

Do not stop just to summarize the project to the user unless explicitly asked or unless no actionable work remains and status is needed.

## When to Use

- after completing a task
- when an oriented worker is idle
- when you want to nudge a worker back into the loop

## Tips

- This is a re-entry skill, not a full orientation skill.
- If a direct assignment is present in mail or from the operator, follow that instead of generic triage.
