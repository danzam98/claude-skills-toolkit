# NTM Agent Prompts

Quick reference for managing the agent swarm.

## Prompt Files

| File | Purpose | Usage |
|------|---------|-------|
| `01-start-agent.md` | Initial marching orders | Start of session |
| `02-git-manager.md` | Dedicated git agent | Pane 1 only |
| `03-next-bead.md` | Move to next task | After completing work |
| `04-review-own-code.md` | Self-review | After each bead |
| `05-review-others-code.md` | Cross-agent review | Periodically |
| `06-random-explore.md` | Bug hunting | When idle |
| `07-commit-all.md` | Commit changes | Git manager or any agent |
| `08-ui-polish.md` | UI/UX improvements | After features complete |
| `09-test-coverage.md` | Test audit | Before release |
| `10-reread-agents.md` | Refresh context | After compaction |

## Quick Commands

```bash
# Start all agents
ntm send danielfischer-ai --cc --file docs/agent-prompts/01-start-agent.md

# Set up git manager (pane 1)
ntm send danielfischer-ai --pane=1 --file docs/agent-prompts/02-git-manager.md

# Move agents to next bead
ntm send danielfischer-ai --cc --file docs/agent-prompts/03-next-bead.md

# Review cycle
ntm send danielfischer-ai --cc --file docs/agent-prompts/04-review-own-code.md

# Cross-review
ntm send danielfischer-ai --cc --file docs/agent-prompts/05-review-others-code.md

# Commit (to git manager)
ntm send danielfischer-ai --pane=1 --file docs/agent-prompts/07-commit-all.md

# Refresh after compaction
ntm send danielfischer-ai --cc --file docs/agent-prompts/10-reread-agents.md
```

## Workflow

1. **Setup** (once):
   ```bash
   ntm add danielfischer-ai --cc=2  # Add more agents if needed
   ntm send danielfischer-ai --pane=1 --file docs/agent-prompts/02-git-manager.md
   ntm send danielfischer-ai --cc --file docs/agent-prompts/01-start-agent.md
   ```

2. **Work Loop** (repeat):
   ```bash
   # Agents work on beads...
   # After completing a bead:
   ntm send danielfischer-ai --cc --file docs/agent-prompts/04-review-own-code.md
   # Keep reviewing until clean, then:
   ntm send danielfischer-ai --cc --file docs/agent-prompts/03-next-bead.md
   ```

3. **Periodic**:
   ```bash
   ntm send danielfischer-ai --cc --file docs/agent-prompts/05-review-others-code.md
   ntm send danielfischer-ai --pane=1 --file docs/agent-prompts/07-commit-all.md
   ```

4. **After Compaction**:
   ```bash
   ntm send danielfischer-ai --cc --file docs/agent-prompts/10-reread-agents.md
   ```

## Monitor Progress

```bash
ntm activity danielfischer-ai      # Agent states
br stats                            # Bead progress
bv --robot-next                     # Top priority
```
