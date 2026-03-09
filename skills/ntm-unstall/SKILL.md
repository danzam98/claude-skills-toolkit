---
name: ntm-unstall
description: Find beads stuck in-progress by dead agents, reset them to open, then pick up the highest-impact work
version: 1.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "beads", "recovery", "stalled"]
---
# Unstall the Queue

Find beads that are stuck `in_progress` with no recent activity (abandoned by dead agents), reset them to `open`, then immediately pick up the highest-impact work.

## Step 1: Find Stalled Beads

```bash
br list --status in_progress --json
```

Review the list. A bead is stalled if:
- It has been `in_progress` for a long time with no corresponding commits or activity
- The agent that claimed it is no longer running
- No recent progress notes or updates exist

## Step 2: Reset Stalled Beads to Open

For each stalled bead identified:

```bash
br update <id> --status open --json
```

Add a note explaining why it was reset:

```bash
br update <id> --reason "Reset from in_progress: no agent activity detected, returning to queue" --json
```

## Step 3: Notify Fellow Agents

Via MCP Agent Mail, send a brief message to the swarm:

> "Recovered N stalled bead(s): [list IDs]. They are back in the open queue. Picking up [highest-priority ID] now."

## Step 4: Find the Highest-Impact Work

Use bv with robot flags to find the best next task (see AGENTS.md for full bv flag reference):

```bash
bv --robot-next      # Top priority recommendation
bv --robot-plan      # Full execution plan with parallel tracks
bv --robot-priority  # Priority recommendations with reasoning
```

## Step 5: Claim and Begin

```bash
br update <id> --status in_progress --json
```

Notify fellow agents what you're working on, then implement.

## When to Use

- When `br ready` returns empty but `br list --status in_progress` shows beads
- When agents have died mid-task and left the queue blocked
- Periodically as a health check on swarm queue state
- When overall velocity feels low despite agents being active

## Tips

- Don't reset a bead another live agent is actively working on — check agent mail first
- If unsure whether an agent is still alive, ask via MCP Agent Mail before resetting
- After resetting, use `bv --robot-insights` to check for cycles or critical path blockages
- This is a good complement to `/ntm-next-bead` when the queue appears empty but isn't
