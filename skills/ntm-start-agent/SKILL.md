---
name: ntm-start-agent
description: Initialize a worker agent with full project context and coordination protocols
version: 3.0.0
author: Daniel Fischer
category: automation
tags: ["ntm", "multi-agent", "swarm", "startup", "coordination"]
---
# Agent Startup Instructions

Read ALL of AGENTS.md super carefully before doing anything else. Pay special attention to:

1. **Rule Number 1** — NEVER delete files without explicit permission
2. **Automatic Skill Triggers** — You MUST follow these triggers automatically
3. **Git Workflow** — Do NOT push yourself; notify the git manager after committing
4. **Tech Stack & Check Commands** — Note the exact commands for this project; do not assume

Then use your code investigation agent mode to understand the codebase architecture.

## Required Setup

1. **Check for `./robot`** — if it doesn't exist, run `/robot-mode-maker` first
2. **Get project health snapshot**: `./robot status --json` (or `bv --robot-triage` fallback)
3. **Establish your agent identity** using the Session Identity Protocol below
4. **Check your inbox** and respond to any pending messages

## Session Identity Protocol

Agent identities must persist across context compactions. Follow this protocol:

### Step 1: Determine Your Session UUID

```bash
# Get the project directory from pwd or AGENTS.md
PROJECT_DIR=$(pwd)

# Find the Claude projects directory for this project
# Replace / with - to match Claude's directory naming
PROJECT_SLUG=$(echo "$PROJECT_DIR" | sed 's|^/||; s|/|-|g')
CLAUDE_PROJECT_DIR="$HOME/.claude/projects/-$PROJECT_SLUG"

# Get your session UUID (most recently modified transcript)
SESSION_UUID=$(basename "$(ls -t "$CLAUDE_PROJECT_DIR"/*.jsonl 2>/dev/null | head -1)" .jsonl)
echo "Session UUID: $SESSION_UUID"
```

### Step 2: Check for Existing Identity

```bash
# Create project hash for identity directory
PROJECT_HASH=$(echo -n "$PROJECT_DIR" | md5sum | cut -c1-12)
IDENTITY_DIR="$HOME/.claude/agent-identities/$PROJECT_HASH"
IDENTITY_FILE="$IDENTITY_DIR/$SESSION_UUID.json"

# Check if identity exists
if [ -f "$IDENTITY_FILE" ]; then
    echo "Found existing identity:"
    cat "$IDENTITY_FILE"
    AGENT_NAME=$(jq -r '.agent_name' "$IDENTITY_FILE")
else
    echo "No existing identity for this session"
    AGENT_NAME=""
fi
```

### Step 3: Register with MCP Agent Mail

Call `macro_start_session` with the project's `human_key` (the absolute project path):

- **If identity file exists:** Use the `agent_name` from the file
- **If no identity file:** Omit `agent_name` to auto-generate one

```
mcp__mcp-agent-mail__macro_start_session
  human_key: "<PROJECT_DIR>"
  agent_name: "<AGENT_NAME or omit>"
  agent_role: "Brief description of your role"
```

### Step 4: Save Your Identity

After successful registration, save your identity for recovery after compaction:

```bash
mkdir -p "$IDENTITY_DIR"
cat > "$IDENTITY_FILE" << EOF
{
  "agent_name": "<YOUR_AGENT_NAME>",
  "role": "<YOUR_ROLE>",
  "project_key": "$PROJECT_DIR",
  "created_at": "$(date -Iseconds)"
}
EOF
```

## Starting Work

1. Find priority work: `./robot next --json` (or `bv --robot-next`)
2. Claim the bead: `./robot claim <id>` (or `br update <id> --status in_progress`)
3. Notify agents via MCP Agent Mail what you're working on
4. Implement the task systematically — comply with AGENTS.md and best practice guides
5. Before closing: run `/ntm-review-own` to catch bugs with fresh eyes
6. Close and sync: `./robot done <id>` (or `br close <id>` + `br sync --flush-only`)
7. Commit code and `.beads/` together; notify the git manager — do NOT push yourself
8. Loop: run `/ntm-next-bead`

Don't get stuck in "communication purgatory" — be proactive about starting tasks, but always mark beads and inform fellow agents.

Use ultrathink.

## Required Tools

- **MCP Agent Mail** — inter-agent coordination
- **`./robot`** — standardized project operations (status, next, claim, done, build, files)
- **`bv`** (beads_viewer) — priority-based task selection (fallback if `./robot` unavailable)
- **`br`** (beads_rust) — issue and task tracking

## When to Use

- At the start of a new worker agent session
- When spawning worker agents in an NTM swarm
- To get agents oriented and productive quickly

## Tips

- Send to worker agents only — not the git manager (use `/ntm-git-manager` for that)
- Always claim beads before starting to prevent duplicate work
- All coordination happens through MCP Agent Mail
- Identity files are stored globally in `~/.claude/agent-identities/` to survive fresh clones
