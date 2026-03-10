---
name: ntm-next-bead
description: Direct agent to pick up the next highest-priority task
version: 2.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "beads", "workflow"]
---
# Continue to Next Bead

Reread AGENTS.md so it's still fresh in your mind. Use ultrathink.

Find the most impactful bead to work on next, claim it, and start immediately.

## Step 1: Find Next Task

Use `./robot next` if available, otherwise fall back to `bv --robot-next` directly:

```bash
# Preferred:
./robot next --json

# Fallback:
bv --robot-next
```

## Step 2: Claim and Announce

```bash
# Preferred:
./robot claim <id>

# Fallback:
br update <id> --status in_progress
```

Notify fellow agents via MCP Agent Mail what you're starting. Check for any pending messages and respond before diving in.

## Step 3: Implement

Work systematically and meticulously. Follow AGENTS.md rules at every step. Comply with the best practice guides referenced in AGENTS.md.

## Step 4: Self-Review

Before closing, run `/ntm-review-own` to catch issues with fresh eyes.

## Step 5: Close and Sync

```bash
# Preferred (closes bead + flushes .beads/):
./robot done <id>

# Fallback:
br close <id> --reason "Description of what was done"
br sync --flush-only
git add .beads/
```

Then commit your code and `.beads/` changes together, and notify the git manager.

## Step 6: Loop

Run `/ntm-next-bead` again to pick up the next task.

---

## When to Use

- After an agent completes a task
- When agents are idle and need direction
- To keep the swarm productive

## Tips

- Always claim before starting to prevent duplicate work by other agents
- Communicate via MCP Agent Mail to stay coordinated
- Do NOT push — notify the git manager after committing
