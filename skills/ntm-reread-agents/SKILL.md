---
name: ntm-reread-agents
description: Refresh agent context after memory compaction
version: 2.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "context", "refresh"]
---
# Refresh Context

Reread AGENTS.md so it's still fresh in your mind. Use ultrathink.

Pay special attention to:
- Rule Number 1 (NEVER delete files without permission)
- Git workflow and commit conventions — do NOT push yourself; notify the git manager
- Package manager and check commands — note what AGENTS.md specifies, do not assume
- Code editing discipline
- Issue tracking with br (beads_rust)
- Agent communication protocol
- Any active development phase restrictions

After reading, check:
1. Your agent mail inbox for any messages
2. `./robot status --json` for current project health (or `bv --robot-next` as fallback)
3. `br ready` for available tasks

Then proceed with your current task or pick a new one.

## When to Use

- After context compaction (when agent memory is compressed)
- When agent seems to have forgotten project rules
- Periodically to reinforce key conventions

## Tips

- Critical after long sessions
- Prevents rule violations from context loss
- Keeps agents aligned with project standards
