---
name: ntm-unstall
description: Find beads stuck in-progress by dead agents, reset them to open, then pick up the highest-impact work
version: 2.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "beads", "recovery", "stalled"]
---
# Unstall the Queue

Find beads stuck `in_progress` with no recent activity (abandoned by dead agents), reset them to `open`, then pick up the highest-impact available work.

## Step 1: Check Agent Mail First

**Before resetting anything**, check your inbox to confirm no live agent is actively working the beads you're about to reset. Resetting a bead under an active agent causes conflicts:

```
mcp__mcp-agent-mail__fetch_inbox
```

If another agent is clearly working on a bead, do not reset it — coordinate with them instead.

## Step 2: Find Stalled Beads

```bash
br list --status in_progress --json
```

A bead is stalled if:
- It has been `in_progress` for a long time with no corresponding commits or activity in `git log`
- The agent that claimed it is no longer reachable via agent mail
- No recent progress notes or updates exist on the bead

## Step 3: Reset Stalled Beads to Open

For each confirmed stalled bead:

```bash
br update <id> --status open
br update <id> --reason "Reset from in_progress: no agent activity detected, returning to queue"
```

## Step 4: Notify the Swarm

Via MCP Agent Mail, send a brief message:

> "Recovered N stalled bead(s): [list IDs]. Back in the open queue. Picking up [highest-priority ID] now."

## Step 5: Find the Highest-Impact Work

```bash
# Preferred:
./robot triage --json

# Fallback:
bv --robot-next
bv --robot-plan
```

Check for cycles or critical path blockages if triage looks unusual:

```bash
bv --robot-insights
```

## Step 6: Claim and Begin

```bash
# Preferred:
./robot claim <id>

# Fallback:
br update <id> --status in_progress
```

Notify fellow agents what you're picking up, then implement.

---

## When to Use

- When `br ready` returns empty but `br list --status in_progress` shows beads
- When agents have died mid-task and left the queue blocked
- As a periodic health check on swarm queue state
- When overall velocity feels low despite agents being active

## Tips

- Always check agent mail before resetting — never reset a live agent's work
- After resetting, use `bv --robot-insights` to check for cycles or critical path blockages
- This is a good complement to `/ntm-next-bead` when the queue appears empty but isn't
