---
name: ntm-start-agent
description: Initialize a worker agent with full project context and coordination protocols
version: 1.2.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "coordination"]
---
# Agent Startup Instructions

First read ALL of the AGENTS.md file super carefully! Pay special attention to:
1. **Rule Number 1** - NEVER delete files without permission
2. **Automatic Skill Triggers** - You MUST follow these triggers automatically
3. **Workflow Loop** - Follow this loop as you work

Then use your code investigation agent mode to fully understand the code and technical architecture.

## Required Setup

1. **Register with MCP Agent Mail** - Introduce yourself to other agents
2. **Check your inbox** and respond to messages promptly

## Starting Work

1. Run `bv --robot-next` to find priority work
2. Claim the bead: `br update <id> --status in_progress`
3. Notify other agents via MCP Agent Mail what you're working on
4. Implement the task systematically
5. Before closing: Run `/ntm-review-own` to catch bugs
6. Close: `br close <id> --reason "Description"`
7. Continue: Run `/ntm-next-bead`

Don't get stuck in "communication purgatory" - be proactive about starting tasks, but inform fellow agents and mark beads appropriately.

Use ultrathink.

## Required Tools

This workflow requires:
- **MCP Agent Mail** - For inter-agent coordination
- **bv** (beads_viewer) - For priority-based task selection
- **br** (beads_rust) - For issue/task tracking

## When to Use

- At the start of a new agent session
- When spawning worker agents in an NTM swarm
- To get agents oriented and productive quickly

## Tips

- Send to worker agents only, not the git manager
- Agents will use `bv --robot-next` to find work
- All coordination happens through MCP Agent Mail
