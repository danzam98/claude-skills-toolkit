---
name: ntm-reread-agents
description: Recover cleanly after compaction by reclaiming the same identity, re-reading project authority surfaces, and reconstructing current work before resuming
version: 2.1.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "context", "refresh"]
---
# Rehydrate After Compaction

Use this after memory compaction or after returning from a long idle period when you need to reconstruct context without inventing a new identity.

## Step 1: Reclaim the Same Identity

Before doing anything else:
- reuse your prior identity if this is the same pane/role
- do not register a fresh identity just because memory was compacted
- do not register a fresh identity just because the project was quiet
- if you do not remember your identity, recover it from the project coordination system before acting
- if you truly cannot recover your original identity, prefer a dormant unclaimed project identity that satisfies the idle-reuse threshold defined by AGENTS and has no active obligations over minting a new one

## Step 2: Re-read the Project Authority Surfaces

Re-read `AGENTS.md` fully.

Then follow AGENTS' authority order and re-read the authoritative project-specific surfaces it names, such as:
- the primary architecture or north-star doc
- aligned plan or migration docs
- README
- project CLI docs and status surfaces
- repo-owned project skill definitions

Do not assume which files matter; let AGENTS tell you.

## Step 3: Reconstruct State

Recover the current state before taking action:
- check inbox and recent message threads
- inspect current project status
- inspect the current queue / task state
- determine whether you already own an active task or sticky role
- reconstruct any file reservations or pending handoffs that matter

## Step 4: Resume Correctly

If you already own active work, resume it.
If you are the git manager, return to the git-manager loop.
If you are a worker with no active task, return to the worker loop or use `/ntm-next-bead`.
If there is no actionable work, use `/ntm-review-others` or `/ntm-unstall`, then re-check.

Do not stop to write a project-wide summary to the user unless explicitly asked or unless no actionable work remains and status is needed.

## When to Use

- immediately after compaction
- after a long idle period when the project may have moved
- whenever you realize you have lost the current project state

## Tips

- This is the default recovery path after compaction.
- The goal is to continue work with the same role and identity, not to create a new agent footprint.
