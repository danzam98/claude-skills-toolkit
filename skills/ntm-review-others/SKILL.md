---
name: ntm-review-others
description: Perform cross-agent review and fresh-eyes exploration to catch integration issues and keep the swarm productive when direct implementation work is temporarily thin
version: 2.2.0
author: Daniel Fischer
category: debugging
tags: ["ntm", "multi-agent", "swarm", "review", "peer-review"]
---
# Cross-Agent Review Loop

Use this when direct implementation work is temporarily thin but the swarm should keep producing value.

## Coordination First

Before starting review work:
- check inbox
- announce that you are switching into review mode
- if review is likely to become an edit, reserve the files or surfaces you expect to modify before changing them

## Review Modes

Use one or more of these:

1. Recent-work review: inspect other agents' recent diffs and landing surfaces.
2. Integration review: inspect seams between concurrently changed modules, repos, or canonical artifacts.
3. Fresh-eyes exploration: trace unfamiliar but active code paths and look for obvious bugs, drift, missing tests, or unsafe assumptions.

## Review Process

1. Identify recent or high-risk work using the project's history and coordination surfaces.
2. Inspect the affected code paths and integration points.
3. Look for:
   - integration breakage across modules or repos
   - inconsistent patterns introduced by parallel workers
   - missing validation, tests, or schema alignment
   - contract drift from the north-star or project rules
   - unsafe assumptions that could affect other agents
4. Fix what you can justify directly, or communicate findings clearly if another owner should act.
5. Run the required quality gates for any changes you made.
6. Notify the affected agents and the swarm about what you found and changed.

## After Review

- Return to the normal worker loop.
- Re-check the queue for actionable work.
- If the queue is still stale or blocked, use `/ntm-unstall`.

Do not stop to give the user a project-wide summary unless explicitly asked or unless no actionable work remains and status is required.
