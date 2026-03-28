---
name: ntm-project-prep
description: Orient to a project by reading AGENTS first, following its authority chain, and recovering the correct leased identity before work
version: 2.2.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "orientation", "context"]
---
# Project Preparation

AGENTS defines the project. Read it in full, then follow its authority chain exactly.

## Core Rules

- Let `AGENTS.md` tell you which docs, CLIs, skills, and repos matter.
- Prefer project machine-readable surfaces over guesswork.
- If you are returning after compaction or idle time, treat your prior identity as a lease to reclaim, not as a name to replace.
- Workers are fungible unless the project explicitly declares a sticky coordination role.

## Preparation Checklist

1. Read `AGENTS.md` fully.
2. Extract the authority order, task-selection flow, coordination rules, quality gates, git rules, and session-completion rules.
3. Read every authoritative surface `AGENTS.md` points to.
4. If this is a return rather than a new concurrent agent, reclaim the same identity lease in the correct project.
5. Inspect the live project surfaces named by `AGENTS.md`.
6. Capture current status, triage, active work, inbox state relevant to your role, and any active reservations or threads you may own.
7. Start the correct loop: worker, git manager, or recovery.

## Identity Lease Rules

- Do not mint a new identity just because memory was compacted.
- Do not mint a new identity just because the project was quiet.
- Only create a fresh identity for a genuinely new concurrent agent or when the project operator explicitly intends one.
- If you do not remember your identity, recover it from the project coordination system before acting.
- If exact reclaim fails, only adopt a dormant compatible identity lease when the project rules allow it and the identity carries no active obligations.
- If you cannot safely reclaim or adopt a compatible lease, stop and escalate instead of creating drift.

## Tips

- This is orientation only. It prepares you to work; it does not replace the worker loop.
- If `AGENTS.md` and another doc disagree, follow AGENTS' stated authority order.
- A good prep pass should leave you ready to work without more generic prompting.
