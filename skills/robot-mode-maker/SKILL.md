---
name: robot-mode-maker
description: Create an agent-optimized CLI interface for any project
version: 1.0.0
author: Jeffrey Emanuel
category: automation
tags: ["cli", "automation", "agent", "robot-mode", "ultrathink"]
source: https://jeffreysprompts.com/prompts/robot-mode-maker
x_jfp_generated: true
---
# The Robot-Mode Maker

Design and implement a "robot mode" CLI for this project.

The CLI should be optimized for use by AI coding agents:

1. **JSON Output**: Add --json flag to every command for machine-readable output
2. **Quick Start**: Running with no args shows help in ~100 tokens
3. **Structured Errors**: Error responses include code, message, suggestions
4. **TTY Detection**: Auto-switch to JSON when piped
5. **Exit Codes**: Meaningful codes (0=success, 1=not found, 2=invalid args, etc.)
6. **Token Efficient**: Dense, minimal output that respects context limits

Think about what information an AI agent would need and how to present it most efficiently.

Design the interface before implementing.

## When to Use

- When building a new CLI tool
- When adding agent-friendly features to existing CLI
- When optimizing human-centric tools for AI use

## Tips

- Start with the most common agent workflows
- Test output token counts to ensure efficiency
- Include fuzzy search for discoverability

---

*From [JeffreysPrompts.com](https://jeffreysprompts.com/prompts/robot-mode-maker)*

