# Claude Skills Toolkit

A collection of powerful quality-assurance and development workflow skills for Claude Code that help you write better code, catch bugs early, and plan more effectively.

## What's Included

This toolkit includes **8 powerful skills** that integrate seamlessly with Claude Code:

### 1. Fresh Eyes - Automated Code Review
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
- Code that doesn't match requirements

**Example:**
```
/fresh-eyes
```

**Benefits:**
- **Saves time**: Catches bugs in seconds that might take hours to debug later
- **Learns your patterns**: Understands your codebase conventions
- **Auto-fixes**: Doesn't just report issues, fixes them immediately
- **Cost-effective**: Prevents expensive production bugs

---

### 2. Bug Hunt - Deep Codebase Investigation
Proactively explore your codebase to find hidden bugs, security holes, and performance issues.

**When to use:**
- Before major releases
- When investigating reliability issues
- For security audits
- When inheriting unfamiliar code

**What it finds:**
- **Security**: SQL injection, XSS, CSRF, auth bypass, data exposure
- **Performance**: N+1 queries, missing indexes, memory leaks
- **Reliability**: Missing error handling, race conditions, bad assumptions
- **Bugs**: Logic errors, null handling, edge cases

**Example:**
```
/bug-hunt                           # Explore entire codebase
/bug-hunt app/auth                  # Focus on authentication code
/bug-hunt --security                # Prioritize security issues
```

**Benefits:**
- **Proactive**: Finds bugs before users do
- **Systematic**: Traces execution flows and checks edge cases
- **Prioritized**: Categorizes issues by severity (HIGH/MEDIUM/LOW)
- **Actionable**: Provides specific fixes for each issue

---

### 3. Idea Wizard - Structured Brainstorming
Generate and evaluate improvement ideas for your project with data-driven prioritization.

**When to use:**
- Planning new features or improvements
- Optimizing performance or UX
- Quarterly planning or roadmap creation
- When stuck on how to improve something

**How it works:**
1. Generates 30 diverse ideas across categories (performance, UX, security, reliability)
2. Evaluates each on effort vs. impact
3. Winnows to top 5 with detailed rationale
4. Offers to implement the best idea

**Example:**
```
/idea-wizard                                    # General improvements
/idea-wizard "checkout flow"                    # Specific feature
/idea-wizard --focus performance                # Specific area
```

**Benefits:**
- **Comprehensive**: Considers all aspects (robustness, performance, UX, security)
- **Data-driven**: Scores ideas on impact/effort ratio
- **Actionable**: Provides implementation approach for each idea
- **Strategic**: Balances quick wins with long-term improvements

---

### 4. Plan Review - Pre-Implementation Validation
Review implementation plans to catch errors and bad assumptions before you start coding.

**When to use:**
- After creating a plan in plan mode
- Before starting complex implementations
- When reviewing architecture decisions
- For critical features that need extra scrutiny

**What it checks:**
- **Logic**: Is the approach sound? Any contradictions?
- **Assumptions**: What are we assuming? Are they valid?
- **Completeness**: Are all steps present? Missing dependencies?
- **Risks**: What could go wrong? How do we recover?
- **Verification**: How will we know if it works?

**Example:**
```
/plan-review                    # Review current plan
/plan-review plan.md            # Review specific file
/plan-review --passes 3         # Multiple review passes
```

**Benefits:**
- **Prevents wasted effort**: Catches plan errors before implementation
- **Iterative refinement**: Multiple passes until "steady state"
- **Risk mitigation**: Identifies and documents risks upfront
- **Better estimates**: Complete plans lead to accurate timelines

---

### 5. Peer Review - Senior Engineer Feedback
Structured code review covering bugs, security, performance, style, and testing—like a senior engineer reviewing your PR.

**When to use:**
- Before submitting pull requests
- When you want comprehensive feedback
- For critical code paths (auth, payments, data processing)
- To learn best practices and patterns

**Review aspects:**
- **Bugs & Logic**: Correctness, edge cases, error handling
- **Security**: Input validation, SQL injection, XSS, auth/authz
- **Performance**: Database queries, algorithm complexity, caching
- **Style**: Readability, patterns, documentation
- **Testing**: Coverage, quality, edge cases

**Example:**
```
/peer-review                    # Review recent changes
/peer-review src/auth.ts        # Review specific file
/peer-review --pr 123           # Review GitHub PR
/peer-review --security         # Focus on security
```

**Benefits:**
- **Comprehensive**: Covers all aspects of code quality
- **Learning tool**: Explains why issues matter and how to fix them
- **Severity-based**: Prioritizes blocking issues over nitpicks
- **Production-ready**: Ensures code meets professional standards

---

### 6. Gemini Grounded Research - Web-Backed Research
Research using Gemini with Google Search grounding for real-time, citation-backed answers.

**When to use:**
- Researching current technologies or APIs
- Comparing tools or frameworks
- Checking latest features or documentation
- Fact-checking or staying current with 2026 changes

**Example:**
```
/gemini-grounded-research "What are Slack's collaborative to-do features in 2026?"
/gemini-grounded-research "Compare Stripe vs PayPal payment APIs"
```

**Benefits:**
- **Current information**: Uses real-time web search
- **Cited sources**: Every fact includes web citations
- **Fast**: Returns comprehensive answers in seconds
- **Reliable**: Backed by Google Search grounding

**Requirements:**
- Requires `GEMINI_API_KEY` environment variable
- Get free API key at: https://aistudio.google.com/apikey

---

### 7. PRD - Product Requirements Document Generator
Generate comprehensive Product Requirements Documents for new features and projects.

**When to use:**
- Planning a new feature or product
- Starting a new project
- Creating specifications for development
- Communicating requirements to stakeholders

**Example:**
```
/prd
/prd "user authentication system"
/prd "mobile app redesign"
```

**What it generates:**
- Problem statement and goals
- User stories and use cases
- Technical requirements and constraints
- Success metrics and acceptance criteria
- Implementation timeline and milestones

**Benefits:**
- **Structured thinking**: Forces clear problem definition
- **Stakeholder alignment**: Creates shared understanding
- **Scope clarity**: Prevents feature creep
- **Better estimates**: Complete requirements = accurate timelines

---

### 8. Ralph - PRD to JSON Converter
Convert PRDs into structured JSON format for the Ralph autonomous agent system.

**When to use:**
- After creating a PRD with /prd
- When integrating with Ralph autonomous agents
- For programmatic processing of requirements
- To feed specifications into automation pipelines

**Example:**
```
/ralph
/ralph prd.md
```

**What it generates:**
- Structured JSON with goals, requirements, and acceptance criteria
- Format compatible with Ralph agent system
- Machine-readable specification
- Validation of PRD completeness

**Benefits:**
- **Automation ready**: Enables autonomous agent workflows
- **Consistency**: Ensures all required fields are present
- **Integration**: Works with Ralph and other tools
- **Quality check**: Validates PRD structure

---

## Installation

### Quick Start (Recommended)

1. Clone or download this repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/claude-skills-toolkit.git
   cd claude-skills-toolkit
   ```

### For Mac/Linux:

2. Run the installer:
   ```bash
   ./install.sh
   ```

### For Windows:

2. Run the installer:
   ```
   install.bat
   ```

The installer will:

### For Mac/Linux:

1. Download this toolkit
2. Run the installer:
   ```bash
   chmod +x install-mac.sh
   ./install-mac.sh
   ```

### For Windows:

1. Download this toolkit
2. Right-click `install-windows.bat` and select "Run as Administrator"

The installer will:
- Copy all skills to `~/.claude/skills/`
- Create necessary directories
- Handle existing skills (prompt to overwrite or skip)
- Show installation summary

---

## How to Use

After installation, use any skill by typing its command in Claude Code:

```
/fresh-eyes          # Review recent code changes
/bug-hunt            # Hunt for bugs in codebase
/idea-wizard         # Generate improvement ideas
/plan-review         # Review implementation plan
/peer-review         # Get senior engineer feedback
/gemini-grounded-research "your question"
/prd                 # Generate PRD for a feature
/ralph               # Convert PRD to JSON
```

**Pro Tips:**
1. **Use `/fresh-eyes` automatically**: Set up a git pre-commit hook to run it
2. **Run `/bug-hunt` weekly**: Catch issues before they become problems
3. **Start with `/idea-wizard`**: Before implementing, explore options
4. **Review plans with `/plan-review`**: Save hours by catching errors early
5. **Use `/peer-review` before PRs**: Get feedback before your team does

---

## Workflow Integration

### Test-First Bug Fixing
```
1. Report bug to Claude
2. Claude writes test that reproduces it
3. Test fails (proves bug exists)
4. Run /fresh-eyes or /peer-review
5. Fix is implemented
6. Test passes (proves fix works)
```

### Feature Development
```
1. Run /idea-wizard to explore options
2. Create implementation plan
3. Run /plan-review to validate
4. Implement the feature
5. Run /fresh-eyes after each change
6. Run /peer-review before committing
7. Run /bug-hunt to catch edge cases
```

### Code Review Workflow
```
1. Make changes to code
2. Run /fresh-eyes (quick check)
3. Run /peer-review (comprehensive check)
4. Address blocking/high-severity issues
5. Commit and push
6. Team reviews (fewer issues to fix!)
```

---

## Philosophy

These skills are based on proven software engineering practices:

1. **Fresh Eyes**: Human developers take breaks and review with "fresh eyes"—this automates that
2. **Bug Hunt**: Like exploratory testing, but systematic and thorough
3. **Idea Wizard**: Based on design thinking (diverge → evaluate → converge)
4. **Plan Review**: "Measure twice, cut once"—validate plans before coding
5. **Peer Review**: Simulates senior engineer review with structured checklist
6. **Grounded Research**: Fact-checking with citations prevents hallucinations
7. **PRD Generator**: Forces structured thinking and scope clarity upfront
8. **Ralph Converter**: Bridges human documentation with automated agents

---

## Configuration

### Gemini Grounded Research Setup

To use Gemini Grounded Research, you need a Gemini API key:

1. Get a free API key: https://aistudio.google.com/apikey
2. Add to your environment:

**Mac/Linux:**
```bash
echo 'export GEMINI_API_KEY="your-key-here"' >> ~/.zshrc
source ~/.zshrc
```

**Windows (PowerShell):**
```powershell
[Environment]::SetEnvironmentVariable("GEMINI_API_KEY", "your-key-here", "User")
```

---

## Contributing

Found a bug? Have an idea for improvement? These skills are living documents:

1. Edit the skill.md files in `~/.claude/skills/[skill-name]/`
2. Test your changes
3. Share improvements with the community

---

## Cost Efficiency

Running these skills is cost-effective:

- **Fresh Eyes**: ~$0.01 per review (catches bugs worth hours of debugging)
- **Bug Hunt**: ~$0.05 per hunt (finds critical issues before production)
- **Idea Wizard**: ~$0.02 per session (generates ideas that could take hours of meetings)
- **Plan Review**: ~$0.01 per review (prevents wasted implementation effort)
- **Peer Review**: ~$0.03 per review (cheaper than senior engineer time)
- **Gemini Research**: ~$0.001 per query (fast, cited research)
- **PRD Generator**: ~$0.02 per PRD (saves hours of documentation time)
- **Ralph Converter**: ~$0.005 per conversion (instant automation)

**ROI Example**: A single SQL injection bug caught by Bug Hunt could prevent a breach costing millions. The tool pays for itself thousands of times over.

---

## License

MIT License - see LICENSE file for details.

---

## Learn More

- **Claude Code Documentation**: https://github.com/anthropics/claude-code
- **Prompt Engineering Guide**: https://docs.anthropic.com/claude/docs/prompt-engineering
- **Best Practices**: Check your CLAUDE.md and MEMORY.md files for personalized patterns

---

## Troubleshooting

**Skills not showing up?**
- Verify installation: `ls ~/.claude/skills/`
- Restart Claude Code
- Check file permissions: `chmod +x ~/.claude/skills/*/skill.md`

**Gemini Grounded Research not working?**
- Verify API key: `echo $GEMINI_API_KEY`
- Check API quota: https://aistudio.google.com/
- Ensure `curl` and `jq` are installed

**Skills running slowly?**
- Check your Claude Code model (Sonnet is faster than Opus)
- Reduce scope (use specific file paths instead of entire codebase)
- Run in parallel: `/fresh-eyes & /bug-hunt` (if independent)

---

## Version History

**v1.0** (Feb 2026)
- Initial release with 8 core skills
- Fresh Eyes, Bug Hunt, Idea Wizard, Plan Review, Peer Review, Gemini Research, PRD, Ralph
- Mac/Linux and Windows installers
- Comprehensive documentation

---

Made by Daniel Fischer for the Claude Code community
