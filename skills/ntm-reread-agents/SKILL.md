---
name: ntm-reread-agents
description: Refresh agent context and recover identity after memory compaction
version: 3.0.0
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

## Identity Recovery Protocol

After context compaction, you need to recover your agent identity. The compaction summary contains your session UUID in the transcript path.

### Step 1: Extract Session UUID from Compaction Summary

Look for this line in the compaction summary message:
> "read the full transcript at: /home/.../.claude/projects/-<project-slug>/<SESSION_UUID>.jsonl"

Extract the UUID (the filename without `.jsonl`).

### Step 2: Look Up Your Identity

```bash
# Get project directory
PROJECT_DIR=$(pwd)
PROJECT_HASH=$(echo -n "$PROJECT_DIR" | md5sum | cut -c1-12)

# Use the SESSION_UUID from the compaction summary
IDENTITY_FILE="$HOME/.claude/agent-identities/$PROJECT_HASH/<SESSION_UUID>.json"

if [ -f "$IDENTITY_FILE" ]; then
    cat "$IDENTITY_FILE"
    AGENT_NAME=$(jq -r '.agent_name' "$IDENTITY_FILE")
else
    echo "WARNING: No identity file found. You may need to register as a new agent."
fi
```

### Step 3: Reconnect with MCP Agent Mail

Call `macro_start_session` with your recovered identity:

```
mcp__mcp-agent-mail__macro_start_session
  human_key: "<PROJECT_DIR>"
  agent_name: "<AGENT_NAME from identity file>"
  agent_role: "<ROLE from identity file>"
```

If the identity file doesn't exist, you'll need to generate a new identity (omit `agent_name` to auto-generate), then **save it for future recovery**:

```bash
# After macro_start_session returns your new agent name:
mkdir -p "$HOME/.claude/agent-identities/$PROJECT_HASH"
cat > "$HOME/.claude/agent-identities/$PROJECT_HASH/$SESSION_UUID.json" << EOF
{
  "agent_name": "<YOUR_NEW_AGENT_NAME>",
  "role": "<YOUR_ROLE>",
  "project_key": "$(pwd)",
  "created_at": "$(date -Iseconds)"
}
EOF
echo "Identity saved for future compaction recovery"
```

## Post-Recovery Checklist

After recovering your identity:

1. **Check your agent mail inbox** for any messages you may have missed
2. **Run `./robot status --json`** for current project health (or `bv --robot-next` as fallback)
3. **Run `br ready`** to see available tasks
4. **Review your in-progress work** — check if you had any beads claimed before compaction

Then proceed with your current task or pick a new one.

## When to Use

- After context compaction (when agent memory is compressed)
- When agent seems to have forgotten project rules
- Periodically to reinforce key conventions
- When the compaction summary mentions a transcript path

## Tips

- Critical after long sessions
- Prevents rule violations from context loss
- Keeps agents aligned with project standards
- Identity files are stored in `~/.claude/agent-identities/<project-hash>/`
- If identity recovery fails, register fresh and notify the swarm of your new name
