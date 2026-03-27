---
name: ntm-unstall
description: Recover a stalled swarm queue by identifying abandoned in-progress tasks, reopening them safely, and returning the swarm to productive work
version: 2.1.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "beads", "recovery", "stalled"]
---
# Recover a Stalled Queue

Use this when the queue appears empty or stuck even though work should still be moving.

If you are returning from compaction or a long idle period, run `/ntm-reread-agents` first unless you have already reconstructed current state.

## Step 1: Check Coordination State First

Before reopening anything:
- check inbox
- inspect recent coordination messages
- confirm no live agent is still actively working the candidate tasks

Never reset a live agent's work just because it looks quiet.

## Step 2: Find Suspected Stalled Work

Use the project's task tracker commands from AGENTS to identify in-progress work that may be abandoned.

Look for evidence such as:
- long-lived in-progress state with no recent activity
- no recent commits or progress notes
- agent clearly unreachable or inactive
- blocked downstream work caused by the stale claim

## Step 3: Reopen Only Confirmed Abandoned Work

For each confirmed stalled task:
- reopen or reset it using the project task tracker
- leave a clear reason in task history
- avoid silent queue surgery

## Step 4: Notify the Swarm

Send a brief coordination update describing:
- which tasks were recovered
- why they were considered abandoned
- what you are picking up next, if anything

## Step 5: Return the Queue to Motion

After recovery:
- re-run the project's triage flow
- claim the highest-impact actionable task if appropriate
- reserve files before editing
- announce start
- continue the normal worker loop

If there is still no actionable work after recovery, run `/ntm-review-others` and continue monitoring.

Do not stop to produce a project-wide summary for the user unless explicitly asked or unless no actionable work remains and status is required.

## When to Use

- when the queue appears empty but there is stranded in-progress work
- when dead agents appear to have blocked the swarm
- as periodic queue-health recovery during long swarm sessions

## Tips

- Recovery must be conservative: verify abandonment before reopening anything.
- Always communicate recovery actions so other agents understand the queue change.
