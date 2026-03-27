---
name: ntm-project-prep
description: Deep project orientation - read AGENTS.md, then follow its authority chain and inspect the project surfaces it names before doing any work
version: 2.1.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "orientation", "context"]
---
# Project Preparation

Before touching code, claiming work, or registering a fresh agent identity, orient yourself fully. No shortcuts.

## Step 1: Read AGENTS.md in Full

Read the entire `AGENTS.md` file.

Extract these items explicitly:
- authority order between project documents
- task-selection commands and task-system rules
- coordination tools and registration rules
- file-reservation rules
- quality gates and check commands
- git/commit/push rules
- session-completion expectations

If AGENTS says certain docs or tools are authoritative, treat that as the contract of record.

## Step 2: Follow the Project Authority Chain

Read every project-specific file that `AGENTS.md` says is authoritative.

Typical examples include:
- the primary architecture or north-star document
- the aligned implementation or migration plan
- the project README
- machine-readable project CLI docs such as `./robot help --json`, `./robot docs --json`, `./robot plan --json`, or similar
- repo-owned project skill definitions if AGENTS points to a project skill directory

Do not hardcode assumptions about which files these are. Let AGENTS tell you.

## Step 3: Reuse Identity If This Is a Return, Not a New Agent

If this is a compaction recovery or an idle return in the same pane/role, reclaim the same agent identity.

Rules:
- do not create a new identity just because memory was compacted
- do not create a new identity just because the project was quiet for a while
- only create a fresh identity for a genuinely new concurrent agent
- if you do not remember your identity, recover it from the project coordination system before acting
- if you truly cannot recover your original identity, prefer reusing a dormant unclaimed project identity that satisfies the idle-reuse threshold defined by AGENTS and carries no active obligations rather than minting a brand-new one

Use the project registration rules from AGENTS so you register in the correct project and with the correct identity.

## Step 4: Inspect the Project Surfaces AGENTS Names

Investigate the codebase and tooling based on the project structure described by AGENTS, not on generic framework guesses.

Inspect only the relevant surfaces AGENTS points to, such as:
- top-level repo layout
- project CLI entrypoints
- implementation repo entrypoints
- schema or contract directories
- build/pipeline modules
- plugin or domain-pack surfaces
- test directories and verification commands
- project-owned skill directories

Map what exists, what is missing, and what appears to be the current active implementation surface.

## Step 5: Capture the Live Project State

Use the project tools AGENTS specifies to inspect current state.

At minimum, gather:
- machine-readable project status
- task queue / triage state
- current in-progress work
- available commands exposed by the project CLI, if one exists
- any recent coordination messages relevant to your role

## Step 6: Confirm Readiness Internally

Before starting work, make sure you know:
- the project purpose and current north-star
- the rules you must not violate
- the exact quality gates for this project
- the coordination, reservation, and task-selection flow
- whether you are resuming an existing role or starting a new one

Only then should you proceed to worker startup, git-manager startup, or task pickup.

## When to Use

- at the start of a fresh agent session
- when onboarding a new agent to a swarm
- after major architectural change
- after a long idle period when the project may have moved
- before resuming after compaction if you need full re-orientation

## Tips

- This skill is orientation only. It prepares you to work; it does not replace the worker loop.
- If AGENTS and another doc disagree, follow AGENTS' stated authority order rather than making assumptions.
- Prefer the project's own machine-readable surfaces over ad hoc exploration when they exist.
- This skill supersedes `ntm-start-agent` for initial orientation.
