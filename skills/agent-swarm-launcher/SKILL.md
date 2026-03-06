---
name: agent-swarm-launcher
description: Initialize multiple agents with full context and coordination protocols
version: 1.0.0
author: Jeffrey Emanuel
category: automation
tags: ["multi-agent", "coordination", "swarm", "ultrathink"]
source: https://jeffreysprompts.com/prompts/agent-swarm-launcher
x_jfp_generated: true
---
# Agent Swarm Launcher

First read ALL of the AGENTS.md file and README.md file super carefully and understand ALL of both! Then use your code investigation agent mode to fully understand the code, and technical architecture and purpose of the project. Then register with MCP Agent Mail and introduce yourself to the other agents. Be sure to check your agent mail and to promptly respond if needed to any messages; then proceed meticulously with your next assigned beads, working on the tasks systematically and meticulously and tracking your progress via beads and agent mail messages. Don't get stuck in "communication purgatory" where nothing is getting done; be proactive about starting tasks that need to be done, but inform your fellow agents via messages when you do so and mark beads appropriately. When you're not sure what to do next, use the bv tool mentioned in AGENTS.md to prioritize the best beads to work on next; pick the next one that you can usefully work on and get started. Make sure to acknowledge all communication requests from other agents and that you are aware of all active agents and their names.

## When to Use

- When launching multiple agents on a project
- For coordinated multi-agent workflows
- When using beads task management with agent mail

## Tips

- Requires Agent Mail MCP server to be running
- Works with beads (br) for task management
- Prevents agents from duplicating work

## NTM Workflow Prompts

This skill includes reusable prompt files for NTM (Named Tmux Manager) in `ntm-prompts/`:

| File | Purpose | When to Use |
|------|---------|-------------|
| `01-start-agent.md` | Initial marching orders | Start of session |
| `02-git-manager.md` | Dedicated git coordination | Pane 1 only |
| `03-next-bead.md` | Move to next task | After completing work |
| `04-review-own-code.md` | Self-review for bugs | After each bead |
| `05-review-others-code.md` | Cross-agent code review | Periodically |
| `06-random-explore.md` | Random bug hunting | When idle |
| `07-commit-all.md` | Commit in logical groups | Git manager or any agent |
| `08-ui-polish.md` | UI/UX refinement | After features complete |
| `09-test-coverage.md` | Test coverage audit | Before release |
| `10-reread-agents.md` | Refresh context | After compaction |

### Quick Start Commands

```bash
# Setup (copy ntm-prompts to your project)
cp -r ~/.claude/skills/agent-swarm-launcher/ntm-prompts docs/agent-prompts

# Start agents
ntm add myproject --cc=3
ntm send myproject --pane=1 --file docs/agent-prompts/02-git-manager.md
ntm send myproject --cc --file docs/agent-prompts/01-start-agent.md

# Work loop
ntm send myproject --cc --file docs/agent-prompts/04-review-own-code.md
ntm send myproject --cc --file docs/agent-prompts/03-next-bead.md

# Periodic
ntm send myproject --cc --file docs/agent-prompts/05-review-others-code.md
ntm send myproject --pane=1 --file docs/agent-prompts/07-commit-all.md
```

---

*From [JeffreysPrompts.com](https://jeffreysprompts.com/prompts/agent-swarm-launcher)*

