# Claude Skills Toolkit

58 skills for Claude Code and Codex CLI covering code review, planning, UI/UX, testing, automation, and NTM swarm coordination. The same SKILL.md format works in both CLIs, and the installer writes to both by default.

Includes skills created or inspired by Jeffrey Emanuel alongside project workflow and swarm coordination skills.

## Quick Install

### Option A: Download the Zip

A pre-built [`claude-skills-md.zip`](https://github.com/danzam98/claude-skills-toolkit/raw/master/claude-skills-md.zip) contains the full skill bundle in a single download:

```bash
curl -fsSL https://github.com/danzam98/claude-skills-toolkit/raw/master/claude-skills-md.zip -o claude-skills-md.zip

# Claude Code
unzip claude-skills-md.zip -d ~/.claude/skills/

# Codex CLI
unzip claude-skills-md.zip -d ~/.codex/skills/
```

### Option B: Clone and Install

**Mac/Linux:**
```bash
git clone https://github.com/danzam98/claude-skills-toolkit.git
cd claude-skills-toolkit
./install.sh
```

**Windows:**
```cmd
git clone https://github.com/danzam98/claude-skills-toolkit.git
cd claude-skills-toolkit
install.bat
```

### Installer Options

```bash
./install.sh                              # Install all skills to Claude + Codex (interactive)
./install.sh --all --force                # Install all, overwrite existing
./install.sh fresh-eyes bug-hunt          # Install specific skills (Claude + Codex)
./install.sh --target=claude fresh-eyes   # Install only to Claude Code
./install.sh --target=codex bug-hunt      # Install only to Codex CLI
./install.sh -f peer-review               # Install with overwrite
./install.sh --list                       # List available skills
./install.sh --help                       # Show help
```

By default, every install writes to both `~/.claude/skills/` and `~/.codex/skills/`. Use `--target=claude` or `--target=codex` to install to only one CLI.

### Install Individual Skills

**Mac/Linux:**
```bash
# One-liner to install a specific skill into both CLIs (replace SKILL_NAME)
mkdir -p ~/.claude/skills/SKILL_NAME ~/.codex/skills/SKILL_NAME && \
  curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/SKILL_NAME/SKILL.md -o ~/.claude/skills/SKILL_NAME/SKILL.md && \
  cp ~/.claude/skills/SKILL_NAME/SKILL.md ~/.codex/skills/SKILL_NAME/SKILL.md

# Examples:
mkdir -p ~/.claude/skills/fresh-eyes ~/.codex/skills/fresh-eyes && \
  curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/fresh-eyes/SKILL.md -o ~/.claude/skills/fresh-eyes/SKILL.md && \
  cp ~/.claude/skills/fresh-eyes/SKILL.md ~/.codex/skills/fresh-eyes/SKILL.md
```

**Or clone and copy specific skills:**
```bash
git clone https://github.com/danzam98/claude-skills-toolkit.git
cp -r claude-skills-toolkit/skills/fresh-eyes ~/.claude/skills/
cp -r claude-skills-toolkit/skills/fresh-eyes ~/.codex/skills/
```

---

## Prerequisites

### For all skills
- [Claude Code](https://claude.ai/code) and/or [Codex CLI](https://github.com/openai/codex) installed and configured. Codex CLI version 0.118.0 or newer reads `~/.codex/skills/` using the same SKILL.md format as Claude Code.

### For NTM Swarm skills (`ntm-*`)

NTM swarm skills require additional tooling for full functionality. All tools fall back gracefully when absent, but the full workflow needs:

| Tool | Purpose | Install |
|------|---------|---------|
| **br** (beads_rust) | Issue tracking via `.beads/` files | [github.com/Dicklesworthstone/beads_rust](https://github.com/Dicklesworthstone/beads_rust) |
| **bv** (beads_viewer) | Graph-aware task triage and prioritization | [github.com/Dicklesworthstone/beads_viewer](https://github.com/Dicklesworthstone/beads_viewer) |
| **MCP Agent Mail** | Inter-agent messaging for swarm coordination | Configure as an MCP server in Claude Code settings |
| **tmux** | Terminal multiplexer for running multiple agents | `brew install tmux` / `apt install tmux` |

> NTM swarm skills work fine for single-agent workflows without tmux — just invoke them directly in Claude Code. tmux is only needed for multi-agent parallel sessions.

---

## Skills Reference

### Code Quality & Review (6 skills)

| Skill | Command | Description |
|-------|---------|-------------|
| **Fresh Eyes** | `/fresh-eyes` | Automated code review that catches bugs, security issues, and logic errors before they ship |
| **Bug Hunt** | `/bug-hunt` | Deep codebase investigation to find hidden bugs, security holes, and performance issues |
| **Bug Hunter** | `/bug-hunter` | Randomly explore and trace code execution flows to find obvious mistakes and issues |
| **Peer Review** | `/peer-review` | Structured code review covering bugs, security, performance, style, and testing |
| **Peer Code Reviewer** | `/peer-code-reviewer` | Cross-agent code review to catch issues from parallel work streams |
| **Plan Review** | `/plan-review` | Validate implementation plans to catch errors and bad assumptions before coding |

**Install just this category:**
```bash
./install.sh -f fresh-eyes bug-hunt bug-hunter peer-review peer-code-reviewer plan-review
```

### Ideation & Planning (7 skills)

| Skill | Command | Description |
|-------|---------|-------------|
| **Idea Wizard** | `/idea-wizard` | Generate and evaluate improvement ideas with data-driven prioritization |
| **100-to-10 Filter** | `/hundred-to-ten-filter` | Generate 100 ideas, then ruthlessly filter to the 10 most brilliant |
| **Next Best Move** | `/next-best-move` | Find the single smartest, most radically innovative addition to the project right now |
| **PRD Generator** | `/prd` | Generate comprehensive Product Requirements Documents for features and projects |
| **Premortem Planner** | `/premortem-planner` | Imagine failure 6 months out and revise the plan to prevent it |
| **Project Opinion** | `/project-opinion-elicitor` | Get honest, critical assessment of the project from the agent's perspective |
| **System Weaknesses** | `/system-weaknesses` | Identify the weakest parts of the system that need improvement |

**Install just this category:**
```bash
./install.sh -f idea-wizard hundred-to-ten-filter next-best-move prd premortem-planner project-opinion-elicitor system-weaknesses
```

### UI/UX (6 skills)

| Skill | Command | Description |
|-------|---------|-------------|
| **Stripe-Level UI** | `/stripe-level-ui` | Build polished UI/UX components with strong attention to visual quality |
| **UI Polish** | `/ui-polish` | Iterative refinement passes for apps that already work and need to look better |
| **UX Audit** | `/ux-audit` | Systematic UX evaluation using Nielsen heuristics and accessibility checks |
| **React Component Generator** | `/react-component-generator` | React 19 components with TypeScript, accessibility, and tests built in |
| **Interactive Visualization Creator** | `/interactive-visualization-creator` | Interactive visualizations for Next.js using SVG, Canvas, Three.js, and Framer Motion |
| **Admin Page for Next.js Sites** | `/admin-page-for-nextjs-sites` | Cohesive Next.js SaaS admin cockpits covering permissions, audit, analytics, and ops |

**Install just this category:**
```bash
./install.sh -f stripe-level-ui ui-polish ux-audit react-component-generator interactive-visualization-creator admin-page-for-nextjs-sites
```

### Refactoring & Optimization (5 skills)

| Skill | Command | Description |
|-------|---------|-------------|
| **Code Reorganizer** | `/code-reorganizer` | Restructure scattered code files into a sensible, intuitive folder structure |
| **Deep Performance Audit** | `/deep-performance-audit` | Systematic identification of optimization opportunities with proof requirements |
| **Stub Eliminator** | `/stub-eliminator` | Replace all stubs, placeholders, and mocks with production-ready code |
| **De-Slopify** | `/de-slopify` | Remove telltale AI writing patterns from documentation and text |
| **Multi-Model Synthesis** | `/multi-model-synthesis` | Blend competing LLM outputs into a superior hybrid plan |

**Install just this category:**
```bash
./install.sh -f code-reorganizer deep-performance-audit stub-eliminator de-slopify multi-model-synthesis
```

### Testing & Deployment (7 skills)

| Skill | Command | Description |
|-------|---------|-------------|
| **E2E Pipeline Validator** | `/e2e-pipeline-validator` | Prove the entire system works with real data, no mocks allowed |
| **Deployment Verifier** | `/deployment-verifier` | Verify live deployment works with automated browser testing |
| **Testing Fuzzing** | `/testing-fuzzing` | Coverage-guided, structure-aware, differential, stateful, and protocol fuzzing with AFL++ CMPLOG, persistent mode, and sanitizers |
| **Testing Golden Artifacts** | `/testing-golden-artifacts` | Snapshot and approval test suites that freeze known-good outputs and catch regressions via exact comparison |
| **Testing Real-Service E2E (No Mocks)** | `/testing-real-service-e2e-no-mocks` | Mock-free integration and E2E tests against real databases and APIs with transaction rollback isolation |
| **E2E Testing for Webapps** | `/e2e-testing-for-webapps` | Next.js, Playwright, and Supabase: OAuth bypass via test users, interactive debugging, visual QA, Electron testing |
| **Test E2E Webapps** | `/test-e2e-webapps` | Next.js, Playwright, and Supabase: page objects, console monitoring, visual regression, test user provisioning |

**Install just this category:**
```bash
./install.sh -f e2e-pipeline-validator deployment-verifier testing-fuzzing testing-golden-artifacts testing-real-service-e2e-no-mocks e2e-testing-for-webapps test-e2e-webapps
```

### Automation & Agents (7 skills)

| Skill | Command | Description |
|-------|---------|-------------|
| **Agent Swarm Launcher** | `/agent-swarm-launcher` | Initialize multiple agents with full context and coordination protocols |
| **Robot Mode Maker** | `/robot-mode-maker` | Create an agent-optimized CLI interface for any project |
| **CLI Error Tolerance** | `/cli-error-tolerance` | Make CLI tools forgiving of minor syntax issues for agent ergonomics |
| **Git Committer** | `/git-committer` | Intelligently commit all changed files in logical groupings with detailed messages |
| **Ralph** | `/ralph` | Convert PRDs to JSON format for the Ralph autonomous agent system |
| **Repeatedly Apply Skill** | `/repeatedly-apply-skill` | Iteratively apply any skill N times with progressive deepening and subagent delegation |
| **Beads Workflow** | `/beads-workflow` | Convert markdown plans into actionable beads with dependencies, polishing, and swarm-ready task graphs |

**Install just this category:**
```bash
./install.sh -f agent-swarm-launcher robot-mode-maker cli-error-tolerance git-committer ralph repeatedly-apply-skill beads-workflow
```

### Workflow & Documentation (5 skills)

| Skill | Command | Description |
|-------|---------|-------------|
| **Deep Project Primer** | `/deep-project-primer` | Essential first step to fully understand a project before any work |
| **README Reviser** | `/readme-reviser` | Update documentation for recent changes, framing them as how it always was |
| **Gemini Research** | `/gemini-grounded-research` | Web-backed research using Gemini with Google Search grounding for real-time, citation-backed answers |
| **BD to BR Migration** | `/bd-to-br-migration` | Migrate docs from bd (beads) to br (beads_rust) |
| **Cost Estimate** | `/cost-estimate` | Estimate development cost of a codebase with LOC analysis, market rates, org overhead, team multipliers, and Claude ROI |

**Install just this category:**
```bash
./install.sh -f deep-project-primer readme-reviser gemini-grounded-research bd-to-br-migration cost-estimate
```

### NTM Swarm Skills (12 skills)

> **NTM (Named Tmux Manager)** is a multi-agent orchestration pattern where multiple Claude agents work in parallel on a single project, coordinated through a shared task queue (beads), MCP Agent Mail for inter-agent messaging, and a small number of sticky coordination roles when necessary. These skills are purpose-built for NTM swarm workflows.
>
> NTM skills are **framework-agnostic** — they work with any project type (Next.js, Rails, Vite, HTML mockups, CLIs, etc.). Project-specific commands and paths live in `AGENTS.md`; the skills contain workflow, recovery, and coordination logic. They prefer the project’s own authority chain and machine-readable surfaces, whether that is `./robot` or something else.

| Skill | Command | Description |
|-------|---------|-------------|
| **NTM Project Prep** | `/ntm-project-prep` | Read `AGENTS.md`, follow the project’s authority chain, inspect live project surfaces, and recover the correct identity lease before work starts |
| **NTM Start Agent** | `/ntm-start-agent` | Resume a fungible worker loop that checks mail, claims work, reserves files, reviews, and keeps moving without waiting for re-prompts |
| **NTM Next Bead** | `/ntm-next-bead` | Re-enter the worker loop by checking coordination state, continuing owned work first, or taking the next actionable task |
| **NTM Git Manager** | `/ntm-git-manager` | Run the sticky git-coordination role for a swarm, preserve the same identity lease, and keep landing work clean |
| **NTM Commit All** | `/ntm-commit-all` | Commit all pending changes in logical groupings with beads sync; notifies git manager to push |
| **NTM Reread Agents** | `/ntm-reread-agents` | Recover cleanly after compaction by reclaiming the same identity lease, re-reading authority surfaces, and reconstructing current work before resuming |
| **NTM Review Own** | `/ntm-review-own` | Agent self-review quality gate using project check commands from AGENTS.md |
| **NTM Review Others** | `/ntm-review-others` | Perform cross-agent review and fresh-eyes exploration to keep the swarm productive when direct implementation work is temporarily thin |
| **NTM Bug Hunt** | `/ntm-bug-hunt` | Random codebase exploration using `./robot files` for file discovery, then deep bug investigation |
| **NTM Test Coverage** | `/ntm-test-coverage` | Audit and expand test coverage with comprehensive logging |
| **NTM UI Polish** | `/ntm-ui-polish` | UI/UX refinement pass for world-class visual polish |
| **NTM Unstall** | `/ntm-unstall` | Recover a stalled swarm queue by conservatively reopening abandoned work and returning fungible workers to productive motion |

**Install just this category:**
```bash
./install.sh -f ntm-project-prep ntm-start-agent ntm-next-bead ntm-git-manager ntm-commit-all ntm-reread-agents ntm-review-own ntm-review-others ntm-bug-hunt ntm-test-coverage ntm-ui-polish ntm-unstall
```

### Infrastructure (1 skill)

| Skill | Command | Description |
|-------|---------|-------------|
| **RCH** | `/rch` | Remote compilation helper for offloading cargo/gcc/bun builds to workers |

**Install just this category:**
```bash
./install.sh -f rch
```

---

## Detailed Skill Descriptions

### Fresh Eyes - Automated Code Review
Automatically review your code changes to catch bugs before they ship.

**When to use:**
- After writing or modifying code
- Before committing changes to git
- When you want an extra layer of quality assurance

**What it catches:**
- Logic errors and off-by-one bugs
- Missing null checks and error handling
- Security vulnerabilities (SQL injection, XSS, auth bypass)
- Performance issues (N+1 queries, unnecessary loops)

```
/fresh-eyes
```

---

### Bug Hunt - Deep Codebase Investigation
Proactively explore your codebase to find hidden bugs, security holes, and performance issues.

**When to use:**
- Before major releases
- When investigating reliability issues
- For security audits

```
/bug-hunt                    # Explore entire codebase
/bug-hunt app/auth           # Focus on specific area
```

---

### Idea Wizard - Structured Brainstorming
Generate and evaluate improvement ideas for your project with data-driven prioritization.

**How it works:**
1. Generates 30 diverse ideas across categories
2. Evaluates each on effort vs. impact
3. Winnows to top 5 with detailed rationale
4. Offers to implement the best idea

```
/idea-wizard                         # General improvements
/idea-wizard "checkout flow"         # Specific feature
```

---

### Next Best Move - The Single Smartest Addition
Reads your AGENTS.md and project plan, then uses deep extended thinking to identify the one most impactful addition you could make right now.

**What makes it different from Idea Wizard:**
- Produces exactly one answer, not a ranked list
- Forces a strategic lens: what unlocks the most, not just what's useful
- Requires grounding in the actual project state first

```
/next-best-move
```

---

### Deep Performance Audit
Systematic identification of optimization opportunities with proof requirements.

**Methodology:**
- Baseline metrics first (p50/p95/p99 latency, throughput)
- Profile before proposing changes
- Isomorphism proof per change
- One optimization per change for clear attribution

```
/deep-performance-audit
```

---

### Gemini Grounded Research
Research using Gemini with Google Search grounding for real-time, citation-backed answers.

**Requirements:** Set `GEMINI_API_KEY` environment variable

```bash
# Get free API key: https://aistudio.google.com/apikey
export GEMINI_API_KEY="your-key-here"
```

```
/gemini-grounded-research "What are the latest React 19 features?"
```

### Cost Estimate - Development Cost Analysis
Analyze any codebase and produce a professional development cost estimate suitable for stakeholders, investors, or clients.

**What it calculates:**
- Lines of code by language/complexity category (Swift, C++, Metal, tests, etc.)
- Base development hours using industry productivity benchmarks
- Overhead multipliers (architecture, debugging, code review, docs, testing)
- Realistic calendar time across company types (solo to enterprise)
- Market-rate research via live WebSearch for current 2025 rates
- Full team cost with supporting roles (PM, design, QA, DevOps, etc.)
- Claude ROI analysis: value per Claude active hour vs. human developer cost

**Output includes:**
- Low/average/high scenario cost tables
- Calendar time with organizational overhead (standups, meetings, context-switching)
- Role breakdown for Growth Company and Enterprise scenarios
- Speed multiplier and net savings vs. hiring a human developer

```
/cost-estimate
```

---

### Repeatedly Apply Skill - Iterative Multi-Pass Improvement
Orchestrate N passes of any skill against a target, each delegated to a fresh subagent with a unique mission.

**How it works:**
1. Reads the target skill and generates N domain-specific missions
2. Creates a `.skill-loop-progress.md` tracking file
3. Delegates each pass to a fresh subagent (no accumulated fatigue)
4. Verifies, commits, and logs each pass before proceeding
5. Stops on convergence, thrashing, or pass cap

**When to use:**
- When one pass of a skill isn't enough
- For iterative polish (UI, docs, bug scanning)
- When you want systematic, progressive deepening

```
/repeatedly-apply-skill 10 /ui-polish      # 10 passes of UI polish
/repeatedly-apply-skill 5 /ubs             # 5 passes of bug scanning
```

---

### Beads Workflow - Plan to Task Graph
Convert markdown plans into actionable beads (tasks) with dependencies using the `br` CLI.

**How it works:**
1. Takes a markdown plan and converts it to granular beads
2. Adds dependency structure (what blocks what)
3. Iterative polishing (6-9 rounds) until steady-state
4. Validates with `br dep cycles` and `bv --robot-insights`

**When to use:**
- Before starting implementation of a plan
- When coordinating multi-agent swarms
- To bridge planning to execution

**Includes reference files:**
- `BEAD-ANATOMY.md` — What makes a good bead
- `PROMPTS.md` — Complete prompt reference for conversion and polishing
- `TROUBLESHOOTING.md` — Worktree errors, sync issues, migration guide

```
/beads-workflow
```

---

### NTM Skills — Design Philosophy

NTM skills separate **workflow logic** from **project specifics**:

- **Skills encode:** process steps, reasoning patterns, decision logic, coordination protocols
- **`AGENTS.md` encodes:** file paths, package manager, check commands, tech stack, design tokens

This means the same skill works identically on a Next.js app, a Vite HTML prototype, a Rails API, or a CLI tool — the skill never assumes a framework. When an agent reads AGENTS.md at startup, it learns everything project-specific; the skills just tell it how to behave.

**Project-local machine-readable surfaces:** NTM skills prefer whatever live surfaces the project declares in `AGENTS.md`, such as `./robot` or other CLI/status tools. Use `/robot-mode-maker` when you want a project-local CLI, but the NTM suite is not hardcoded to require it.

**Fungible workers, sticky exceptions:** Workers are generalists that pull from the same actionable queue. Sticky roles such as the git manager are deliberate exceptions and should preserve the same identity across compaction or long idle periods.

**Git discipline:** Worker agents never push to remote. The dedicated git manager (initialized with `/ntm-git-manager`) is the sole agent that runs `git push` when the project’s policy assigns pushes to that role. Worker agents commit locally and notify the git manager via MCP Agent Mail.

---

## Workflow Examples

### Feature Development
```
1. /deep-project-primer     # Understand codebase
2. /idea-wizard             # Explore options
3. /prd                     # Document requirements
4. /plan-review             # Validate approach
5. [Implement feature]
6. /fresh-eyes              # Quick check
7. /peer-review             # Comprehensive review
8. /git-committer           # Commit logically
```

### Pre-Release Audit
```
1. /bug-hunt                # Find hidden issues
2. /stub-eliminator         # Ensure completeness
3. /e2e-pipeline-validator  # Prove it works
4. /deployment-verifier     # Test live deployment
```

### Multi-Agent Coordination
```
1. /agent-swarm-launcher    # Initialize agents
2. [Agents work in parallel]
3. /peer-code-reviewer      # Cross-review work
4. /git-committer           # Commit all changes
```

### NTM Swarm Workflow
```
1. /ntm-project-prep        # Read AGENTS and recover the correct identity
2. /ntm-git-manager         # Keep one sticky landing and push role
3. /ntm-start-agent         # Start each fungible worker loop
4. /ntm-next-bead           # Re-enter task pickup after a completed bead
5. /ntm-review-own          # Self-review quality gate before closing each bead
6. /ntm-review-others       # Cross-review or fresh-eyes fallback when the queue is thin
7. /ntm-reread-agents       # Recover cleanly after compaction
8. /ntm-unstall             # Reopen only confirmed abandoned work when the queue stalls
```

---

## Individual Installation Commands

After cloning, the simplest install path is `./install.sh -f <skill-names>`, which writes to both `~/.claude/skills/` and `~/.codex/skills/` by default. Add `--target=claude` or `--target=codex` to limit one CLI. The curl commands below only target `~/.claude/skills/` and only work for skills whose only file is `SKILL.md`; for Codex installs or for skills with `references/`, `scripts/`, `templates/`, or `examples/` subdirectories, use `./install.sh` instead.

```bash
# Code Quality
mkdir -p ~/.claude/skills/fresh-eyes && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/fresh-eyes/SKILL.md -o ~/.claude/skills/fresh-eyes/SKILL.md
mkdir -p ~/.claude/skills/bug-hunt && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/bug-hunt/SKILL.md -o ~/.claude/skills/bug-hunt/SKILL.md
mkdir -p ~/.claude/skills/bug-hunter && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/bug-hunter/SKILL.md -o ~/.claude/skills/bug-hunter/SKILL.md
mkdir -p ~/.claude/skills/peer-review && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/peer-review/SKILL.md -o ~/.claude/skills/peer-review/SKILL.md
mkdir -p ~/.claude/skills/peer-code-reviewer && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/peer-code-reviewer/SKILL.md -o ~/.claude/skills/peer-code-reviewer/SKILL.md
mkdir -p ~/.claude/skills/plan-review && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/plan-review/SKILL.md -o ~/.claude/skills/plan-review/SKILL.md

# Ideation & Planning
mkdir -p ~/.claude/skills/idea-wizard && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/idea-wizard/SKILL.md -o ~/.claude/skills/idea-wizard/SKILL.md
mkdir -p ~/.claude/skills/hundred-to-ten-filter && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/hundred-to-ten-filter/SKILL.md -o ~/.claude/skills/hundred-to-ten-filter/SKILL.md
mkdir -p ~/.claude/skills/next-best-move && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/next-best-move/SKILL.md -o ~/.claude/skills/next-best-move/SKILL.md
mkdir -p ~/.claude/skills/prd && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/prd/SKILL.md -o ~/.claude/skills/prd/SKILL.md
mkdir -p ~/.claude/skills/premortem-planner && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/premortem-planner/SKILL.md -o ~/.claude/skills/premortem-planner/SKILL.md
mkdir -p ~/.claude/skills/project-opinion-elicitor && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/project-opinion-elicitor/SKILL.md -o ~/.claude/skills/project-opinion-elicitor/SKILL.md
mkdir -p ~/.claude/skills/system-weaknesses && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/system-weaknesses/SKILL.md -o ~/.claude/skills/system-weaknesses/SKILL.md

# UI/UX (multi-file skills, install.sh required)
./install.sh -f stripe-level-ui ui-polish ux-audit react-component-generator interactive-visualization-creator admin-page-for-nextjs-sites

# Refactoring & Optimization
mkdir -p ~/.claude/skills/code-reorganizer && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/code-reorganizer/SKILL.md -o ~/.claude/skills/code-reorganizer/SKILL.md
mkdir -p ~/.claude/skills/deep-performance-audit && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/deep-performance-audit/SKILL.md -o ~/.claude/skills/deep-performance-audit/SKILL.md
mkdir -p ~/.claude/skills/stub-eliminator && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/stub-eliminator/SKILL.md -o ~/.claude/skills/stub-eliminator/SKILL.md
mkdir -p ~/.claude/skills/de-slopify && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/de-slopify/SKILL.md -o ~/.claude/skills/de-slopify/SKILL.md
mkdir -p ~/.claude/skills/multi-model-synthesis && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/multi-model-synthesis/SKILL.md -o ~/.claude/skills/multi-model-synthesis/SKILL.md

# Testing & Deployment (single-file skills)
mkdir -p ~/.claude/skills/e2e-pipeline-validator && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/e2e-pipeline-validator/SKILL.md -o ~/.claude/skills/e2e-pipeline-validator/SKILL.md
mkdir -p ~/.claude/skills/deployment-verifier && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/deployment-verifier/SKILL.md -o ~/.claude/skills/deployment-verifier/SKILL.md

# Testing & Deployment (multi-file skills, install.sh required)
./install.sh -f testing-fuzzing testing-golden-artifacts testing-real-service-e2e-no-mocks e2e-testing-for-webapps test-e2e-webapps

# Automation & Agents
mkdir -p ~/.claude/skills/agent-swarm-launcher && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/agent-swarm-launcher/SKILL.md -o ~/.claude/skills/agent-swarm-launcher/SKILL.md
mkdir -p ~/.claude/skills/robot-mode-maker && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/robot-mode-maker/SKILL.md -o ~/.claude/skills/robot-mode-maker/SKILL.md
mkdir -p ~/.claude/skills/cli-error-tolerance && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/cli-error-tolerance/SKILL.md -o ~/.claude/skills/cli-error-tolerance/SKILL.md
mkdir -p ~/.claude/skills/git-committer && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/git-committer/SKILL.md -o ~/.claude/skills/git-committer/SKILL.md
mkdir -p ~/.claude/skills/ralph && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ralph/SKILL.md -o ~/.claude/skills/ralph/SKILL.md
mkdir -p ~/.claude/skills/repeatedly-apply-skill && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/repeatedly-apply-skill/SKILL.md -o ~/.claude/skills/repeatedly-apply-skill/SKILL.md
mkdir -p ~/.claude/skills/beads-workflow/references && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/beads-workflow/SKILL.md -o ~/.claude/skills/beads-workflow/SKILL.md && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/beads-workflow/references/PROMPTS.md -o ~/.claude/skills/beads-workflow/references/PROMPTS.md && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/beads-workflow/references/BEAD-ANATOMY.md -o ~/.claude/skills/beads-workflow/references/BEAD-ANATOMY.md && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/beads-workflow/references/TROUBLESHOOTING.md -o ~/.claude/skills/beads-workflow/references/TROUBLESHOOTING.md

# Workflow & Documentation
mkdir -p ~/.claude/skills/deep-project-primer && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/deep-project-primer/SKILL.md -o ~/.claude/skills/deep-project-primer/SKILL.md
mkdir -p ~/.claude/skills/readme-reviser && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/readme-reviser/SKILL.md -o ~/.claude/skills/readme-reviser/SKILL.md
mkdir -p ~/.claude/skills/gemini-grounded-research && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/gemini-grounded-research/SKILL.md -o ~/.claude/skills/gemini-grounded-research/SKILL.md
mkdir -p ~/.claude/skills/bd-to-br-migration && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/bd-to-br-migration/SKILL.md -o ~/.claude/skills/bd-to-br-migration/SKILL.md
mkdir -p ~/.claude/skills/cost-estimate && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/cost-estimate/SKILL.md -o ~/.claude/skills/cost-estimate/SKILL.md

# Infrastructure
mkdir -p ~/.claude/skills/rch && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/rch/SKILL.md -o ~/.claude/skills/rch/SKILL.md

# NTM Swarm Skills
mkdir -p ~/.claude/skills/ntm-project-prep && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-project-prep/SKILL.md -o ~/.claude/skills/ntm-project-prep/SKILL.md
mkdir -p ~/.claude/skills/ntm-start-agent && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-start-agent/SKILL.md -o ~/.claude/skills/ntm-start-agent/SKILL.md
mkdir -p ~/.claude/skills/ntm-next-bead && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-next-bead/SKILL.md -o ~/.claude/skills/ntm-next-bead/SKILL.md
mkdir -p ~/.claude/skills/ntm-git-manager && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-git-manager/SKILL.md -o ~/.claude/skills/ntm-git-manager/SKILL.md
mkdir -p ~/.claude/skills/ntm-commit-all && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-commit-all/SKILL.md -o ~/.claude/skills/ntm-commit-all/SKILL.md
mkdir -p ~/.claude/skills/ntm-reread-agents && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-reread-agents/SKILL.md -o ~/.claude/skills/ntm-reread-agents/SKILL.md
mkdir -p ~/.claude/skills/ntm-review-own && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-review-own/SKILL.md -o ~/.claude/skills/ntm-review-own/SKILL.md
mkdir -p ~/.claude/skills/ntm-review-others && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-review-others/SKILL.md -o ~/.claude/skills/ntm-review-others/SKILL.md
mkdir -p ~/.claude/skills/ntm-bug-hunt && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-bug-hunt/SKILL.md -o ~/.claude/skills/ntm-bug-hunt/SKILL.md
mkdir -p ~/.claude/skills/ntm-test-coverage && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-test-coverage/SKILL.md -o ~/.claude/skills/ntm-test-coverage/SKILL.md
mkdir -p ~/.claude/skills/ntm-ui-polish && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-ui-polish/SKILL.md -o ~/.claude/skills/ntm-ui-polish/SKILL.md
mkdir -p ~/.claude/skills/ntm-unstall && curl -fsSL https://raw.githubusercontent.com/danzam98/claude-skills-toolkit/master/skills/ntm-unstall/SKILL.md -o ~/.claude/skills/ntm-unstall/SKILL.md
```

---

## Templates

Project templates live in the companion [**danzam98/toolkit**](https://github.com/danzam98/toolkit) repo, which provides:

| Resource | Location | Purpose |
|----------|----------|---------|
| `AGENTS.md` template | [`toolkit/templates/AGENTS.md`](https://github.com/danzam98/toolkit/blob/main/templates/AGENTS.md) | Universal agent rules template — fill in `[TODO]` sections for your project |
| `nextjs-static` scaffold | [`toolkit/templates/nextjs-static`](https://github.com/danzam98/toolkit/tree/main/templates/nextjs-static) | Next.js 16 + Tailwind v4 + Cloudflare Pages starter |
| Best-practices guides | [`toolkit/best-practices/`](https://github.com/danzam98/toolkit/tree/main/best-practices) | Authoritative guides agents reference during implementation |

See [Setting Up a New Project](#setting-up-a-new-project) for the full workflow.

---

## Troubleshooting

**Skills not showing up?**
- Verify installation: `ls ~/.claude/skills/` (Claude Code) or `ls ~/.codex/skills/` (Codex CLI)
- Restart Claude Code or Codex CLI
- Check file permissions
- For Codex CLI, confirm you are on version 0.118.0 or newer (`codex --version`)

**Gemini Grounded Research not working?**
- Verify API key: `echo $GEMINI_API_KEY`
- Get key at: https://aistudio.google.com/apikey

---

## Contributing

Found a bug? Have an improvement? Edit the skill.md files and submit a PR.

---

## License

MIT License - see LICENSE file for details.
