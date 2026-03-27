---
name: ntm-review-others
description: Perform cross-agent review to catch integration issues and keep the swarm productive when direct implementation work is temporarily unavailable
version: 2.1.0
author: Daniel Fischer
category: debugging
tags: ["ntm", "multi-agent", "swarm", "review", "peer-review"]
---
# Cross-Agent Review Loop

Review recent work from other agents to catch integration issues, contract drift, missing tests, or unsafe assumptions.

Use this when:
- the queue is temporarily empty
- multiple agents have been working in parallel and integration risk is rising
- you need productive swarm work while waiting for new actionable tasks

## Coordination First

Before starting review work:
- check inbox
- announce that you are switching into cross-agent review mode
- if review is likely to become an edit, reserve the files or surfaces you expect to modify before changing them

## Review Process

1. Identify recent work from other agents using the project's history surfaces.
2. Inspect the diffs and affected code paths.
3. Check for:
   - integration breakage across modules or repos
   - inconsistent patterns introduced by parallel workers
   - missing validation, tests, or schema alignment
   - contract drift from project rules or the north-star
   - unsafe assumptions that could affect other agents
4. Fix issues directly when appropriate, or communicate findings clearly if a different owner should act.
5. Run the project quality gates required for the changes you made.
6. Notify the affected agents and the swarm about what you found and changed.

## After Review

When finished:
- return to the normal worker loop
- re-check the queue for actionable work
- if the queue is still blocked or stale, use `/ntm-unstall`

Do not stop to give a project-wide summary to the user unless explicitly asked or unless no actionable work remains and status is required.

## Tips

- This is productive fallback work, not a reason to go idle.
- Keep the original author informed when you modify or correct their work.
- If review turns into code changes, follow the same reservation, inbox, commit, and handoff discipline as any other task.
