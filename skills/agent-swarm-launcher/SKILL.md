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

## NTM Workflow Skills

Related skills for NTM (Named Tmux Manager) agent swarm workflows:

| Skill | Command | Purpose |
|-------|---------|---------|
| ntm-start-agent | `/ntm-start-agent` | Initialize worker agents |
| ntm-git-manager | `/ntm-git-manager` | Designate git coordinator (sticky role) |
| ntm-next-bead | `/ntm-next-bead` | Move to next priority task |
| ntm-review-own | `/ntm-review-own` | Self-review for bugs |
| ntm-review-others | `/ntm-review-others` | Cross-agent code review |
| ntm-bug-hunt | `/ntm-bug-hunt` | Random codebase exploration |
| ntm-commit-all | `/ntm-commit-all` | Commit changes in logical groups |
| ntm-ui-polish | `/ntm-ui-polish` | UI/UX refinement pass |
| ntm-test-coverage | `/ntm-test-coverage` | Test coverage audit |
| ntm-reread-agents | `/ntm-reread-agents` | Refresh context after compaction |

### Quick Start Workflow

```bash
# Setup - spawn agents with NTM
ntm add myproject --cc=3

# Designate git manager (pane 1)
ntm send myproject --pane=1
# Then type: /ntm-git-manager

# Start worker agents (all other panes)
ntm send myproject --cc
# Then type: /ntm-start-agent

# Work loop - after completing tasks
ntm send myproject --cc
# Then type: /ntm-review-own
# Then type: /ntm-next-bead

# Periodic - commit and cross-review
ntm send myproject --pane=1
# Then type: /ntm-commit-all

ntm send myproject --cc
# Then type: /ntm-review-others

# After context compaction
ntm send myproject --cc
# Then type: /ntm-reread-agents
```

**Note:** The git manager role is "sticky" - it will ignore worker prompts sent via `--cc`.

---

*From [JeffreysPrompts.com](https://jeffreysprompts.com/prompts/agent-swarm-launcher)*

