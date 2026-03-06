---
name: ntm-start-agent
description: Initialize a worker agent with full project context and coordination protocols
version: 1.1.0
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

## Coordination Setup

If MCP Agent Mail is available:
- Register with it and introduce yourself to other agents
- Check your inbox and respond to messages promptly

If MCP Agent Mail is NOT available:
- Coordinate via git commits and bead comments instead

## Starting Work

1. Run `bv --robot-next` to find priority work (or `br ready` if bv unavailable)
2. Claim the bead: `br update <id> --status in_progress`
3. Implement the task systematically
4. Before closing: Run `/ntm-review-own` to catch bugs
5. Close: `br close <id> --reason "Description"`
6. Continue: Run `/ntm-next-bead`

Don't get stuck in "communication purgatory" - be proactive about starting tasks, but inform fellow agents and mark beads appropriately.

Use ultrathink.

## When to Use

- At the start of a new agent session
- When spawning worker agents in an NTM swarm
- To get agents oriented and productive quickly

## Tips

- Send to worker agents only, not the git manager
- Agents will use `bv --robot-next` to find work
- Works with MCP Agent Mail for coordination (optional)
