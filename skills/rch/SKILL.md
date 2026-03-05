---
name: rch
description: >-
  Remote compilation helper. Use when: rch doctor, workers.toml, "no workers",
  "compilation slow", fleet deploy, self-test, or offload cargo/gcc/bun.
---

# RCH — Remote Compilation Helper

Transparently offloads `cargo build`, `bun test`, `gcc` to remote workers. Same commands, faster builds.

<!-- TOC: Diagnosis | Quick Fixes | Worker Config | Install | Commands | Debug | References -->

## Diagnosis Loop

```bash
rch doctor              # What's broken?
rch doctor --fix        # Auto-fix common issues
rch doctor --verbose    # All checks passed? Ready to use
```

**If `--fix` can't solve it → see Quick Fixes or references.**

---

## Quick Fixes (Copy-Paste)

| Symptom | Command |
|---------|---------|
| SSH auth fails | `eval $(ssh-agent) && ssh-add ~/.ssh/your_key` |
| Daemon not running | `rm -f /tmp/rch.sock && rchd &` |
| Hook not installed | `rch hook install --force` |
| No workers available | `vim ~/.config/rch/workers.toml` (add workers) |
| Socket permission | `rm /tmp/rch.sock && rchd` |
| Stale socket | `lsof /tmp/rch.sock` → kill stale process |

---

## Worker Config (`~/.config/rch/workers.toml`)

```toml
[[workers]]
id = "builder"
host = "192.168.1.100"        # IP or hostname
user = "ubuntu"
identity_file = "~/.ssh/id_ed25519"
total_slots = 8               # ≈ CPU cores - 2
priority = 100                # Higher = preferred
tags = ["rust", "bun"]        # Optional capabilities
```

### Auto-Discover from SSH Config

```bash
rch workers discover --from-ssh-config --dry-run  # Preview
rch workers discover --from-ssh-config            # Add to config
```

### Verify Workers

```bash
rch workers probe --all         # Test all workers
rch workers probe worker1 -v    # Test single, verbose
rch workers list                # Show status
```

---

## Commands

- `rch doctor` - Diagnose issues
- `rch status` - Show daemon status
- `rch workers probe --all` - Test all workers
- `rch workers discover --from-ssh-config` - Auto-discover workers
- `rch fleet status` - Show all workers
- `rch self-test` - Full end-to-end verification

---

## Fleet Operations

```bash
rch fleet status             # Show all workers
rch fleet preflight --all    # Verify workers ready
rch fleet deploy --all       # Deploy rch-wkr to workers
rch self-test                # Full end-to-end verification
```

---

## Anti-Patterns

| Don't | Why | Do Instead |
|-------|-----|------------|
| Run daemon as root | Security risk | `systemctl --user start rchd` |
| Skip `rch doctor` | Miss config issues | Always verify first |
| Use `--force` blindly | May break hook | Check `rch hook status` first |
| Ignore transfer errors | Indicates network/disk issues | Check worker disk space, network |

---

## Debug

```bash
RCH_LOG=debug cargo build    # Show hook decisions
RCH_DRY_RUN=1 cargo check    # Test without remote execution
rch doctor --json > diag.json  # Export diagnostics
```

---

## Docs

Full documentation: https://github.com/Dicklesworthstone/remote_compilation_helper
