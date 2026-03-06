---
name: ntm-next-bead
description: Direct agent to pick up the next highest-priority task
version: 1.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "beads", "workflow"]
---
# Continue to Next Bead

Reread AGENTS.md so it's still fresh in your mind. Use ultrathink.

Use `bv --robot-next` to find the most impactful bead to work on next and then start on it immediately.

Remember to:
1. Mark the bead as in_progress: `br update <id> --status in_progress`
2. Communicate what you're working on to your fellow agents via MCP Agent Mail
3. Check for any pending agent mail messages and respond
4. Work systematically and meticulously on the task
5. Mark the bead as completed when done: `br close <id> --reason "Description of what was done"`

Pick the next bead you can actually do usefully now and start coding on it immediately.

## When to Use

- After an agent completes a task
- When agents are idle and need direction
- To keep the swarm productive

## Tips

- Agents will claim beads to prevent duplicate work
- Uses `bv --robot-next` for intelligent prioritization
- Works with MCP Agent Mail for coordination
