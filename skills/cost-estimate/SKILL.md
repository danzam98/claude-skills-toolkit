---
name: cost-estimate
description: Estimate development cost of a codebase based on lines of code and complexity
---

# Cost Estimate Command

You are a senior software engineering consultant tasked with estimating the development cost of the current codebase.

**CRITICAL**: Not all code is created equal. The majority of modern codebases consist of scaffolded, copied, or generated code that should NOT be valued at full custom development rates.

## Step 1: Analyze and CATEGORIZE the Codebase

First, count total lines. Then **categorize each file** into one of these tiers:

### Code Value Tiers

| Tier | Value % | Description | Examples |
|------|---------|-------------|----------|
| **Tier 1: Custom Business Logic** | 100% | Novel code solving unique problems | Custom algorithms, business rules, API handlers with real logic |
| **Tier 2: Custom UI/Components** | 75% | Project-specific UI built from scratch | Custom React components, layouts, animations |
| **Tier 3: Configured Integrations** | 40% | Third-party services wired together | Auth setup, payment integration, API clients |
| **Tier 4: Adapted Library Code** | 15% | Copy-pasted with minor changes | shadcn/ui components, Next.js app router pages |
| **Tier 5: Pure Scaffold/Config** | 5% | Generated or copy-pasted verbatim | Config files, boilerplate, package.json |
| **Tier 6: Content (not code)** | 0% | Text content, documentation | MDX blog posts, README files |

### How to Categorize

**Tier 1 indicators** (100% value):
- Contains business-specific logic (pricing, rules, workflows)
- Has custom algorithms or data transformations
- Non-trivial error handling for real edge cases
- Would require understanding the business to write

**Tier 2 indicators** (75% value):
- Custom UI components built for this project
- Project-specific layouts and page structures
- Custom hooks with real logic
- Styled components with original designs

**Tier 3 indicators** (40% value):
- Integration code (Stripe, Auth0, Cloudflare, etc.)
- API route handlers that mostly call external services
- Database schema definitions
- Queue/worker configurations

**Tier 4 indicators** (15% value):
- Components from shadcn/ui, Radix, or similar
- Next.js/Remix page boilerplate
- Standard CRUD operations
- Copy-pasted patterns from docs

**Tier 5 indicators** (5% value):
- tsconfig.json, eslint.config.js, tailwind.config.js
- package.json, wrangler.toml
- Docker/CI configs from templates
- Generated types, migrations from CLI tools

**Tier 6 indicators** (0% value):
- MDX/Markdown content files
- README, CHANGELOG, docs
- Comments and JSDoc (unless documenting complex logic)

### Categorization Commands

Run these to identify code categories:

```bash
# Find UI library components (Tier 4)
ls src/components/ui/ 2>/dev/null | wc -l

# Find config files (Tier 5)
ls *.config.* *.json wrangler.toml tsconfig.json 2>/dev/null

# Find content files (Tier 6)
find . -name "*.md" -o -name "*.mdx" | wc -l

# Find test files (apply 50% modifier - tests have high boilerplate)
find . -name "*.test.*" -o -name "*.spec.*" | xargs wc -l 2>/dev/null
```

### Calculate Effective Lines of Code

```
Effective LOC = Σ (Lines in Category × Value %)
```

Example:
- 500 lines custom business logic × 100% = 500 effective
- 2000 lines custom UI × 75% = 1500 effective
- 800 lines integrations × 40% = 320 effective
- 3000 lines shadcn/ui × 15% = 450 effective
- 600 lines config × 5% = 30 effective
- 1000 lines content × 0% = 0 effective
- **Total: 7900 raw LOC → 2800 effective LOC**

## Step 2: Calculate Development Hours (using Effective LOC)

Based on industry standards for a **senior full-stack developer** (5+ years experience):

**Hourly Productivity Estimates** (applied to EFFECTIVE lines only):
- Complex business logic: 15-25 lines/hour
- Custom UI/components: 25-40 lines/hour
- Integration code: 30-50 lines/hour
- Standard patterns: 40-60 lines/hour

**Test Code Modifier**: Tests are typically 50% boilerplate. Apply 0.5x to test line counts before categorization.

**Additional Time Factors**:
- Architecture & design: +15% of coding time
- Debugging & troubleshooting: +20% of coding time
- Code review & refactoring: +10% of coding time
- Integration & testing: +15% of coding time

**Calculate total hours**:
```
Base Hours = Effective LOC / Productivity Rate
Total Hours = Base Hours × (1 + Overhead %)
```

## Step 3: Research Market Rates

Use WebSearch to find current hourly rates for senior developers.

Search queries:
- "senior full stack developer hourly rate [current year]"
- "senior software engineer contractor rate United States [current year]"

**Typical ranges (2025-2026)**:
- Remote/mid-market: $75-100/hr
- US average: $100-150/hr
- Premium markets (SF/NYC): $150-200/hr

## Step 4: Calculate Organizational Overhead

Real companies don't have developers coding 40 hours/week.

**Coding Efficiency Factor**:
- **Solo/Startup (lean)**: 65% coding time (~26 hrs/week)
- **Growth company**: 55% coding time (~22 hrs/week)
- **Enterprise**: 45% coding time (~18 hrs/week)

**Calendar Time**:
```
Calendar Weeks = Total Dev Hours / (40 × Efficiency Factor)
```

## Step 5: Generate Cost Estimate

**Important**: Present BOTH the raw LOC count AND the effective LOC calculation to show the methodology clearly.

### Output Format

---

## [Project Name] - Development Cost Estimate

**Analysis Date**: [Current Date]

### Code Categorization

| Category | Raw LOC | Value % | Effective LOC |
|----------|---------|---------|---------------|
| Custom Business Logic (Tier 1) | [X] | 100% | [X] |
| Custom UI/Components (Tier 2) | [X] | 75% | [X] |
| Configured Integrations (Tier 3) | [X] | 40% | [X] |
| Adapted Library Code (Tier 4) | [X] | 15% | [X] |
| Scaffold/Config (Tier 5) | [X] | 5% | [X] |
| Content - not code (Tier 6) | [X] | 0% | 0 |
| **TOTAL** | **[Raw]** | | **[Effective]** |

**Effective LOC Ratio**: [Effective/Raw]% — This is a [typical/lean/heavy] scaffold ratio.

### Development Time Estimate

Using **[Effective LOC]** effective lines:

| Code Type | Effective LOC | Productivity | Hours |
|-----------|---------------|--------------|-------|
| Business Logic | [X] | 20 lines/hr | [X] |
| Custom UI | [X] | 35 lines/hr | [X] |
| Integrations | [X] | 40 lines/hr | [X] |
| Patterns | [X] | 50 lines/hr | [X] |
| **Subtotal** | | | **[X] hrs** |

**Overhead**: +60% (architecture, debugging, review, testing)

**Total Estimated Hours**: [X] hours

### Cost Estimate

| Scenario | Hourly Rate | Total Hours | **Total Cost** |
|----------|-------------|-------------|----------------|
| Low-end | $75 | [X] | **$[X]** |
| Average | $125 | [X] | **$[X]** |
| High-end | $175 | [X] | **$[X]** |

**Recommended Estimate**: **$[X] - $[X]**

### Calendar Time

| Company Type | Efficiency | Calendar Weeks | Calendar Time |
|--------------|------------|----------------|---------------|
| Solo/Startup | 65% | [X] weeks | ~[X] months |
| Growth Company | 55% | [X] weeks | ~[X] months |
| Enterprise | 45% | [X] weeks | ~[X] months |

---

## Step 6: Claude ROI Analysis (if applicable)

If this codebase was built with Claude:

**Project Timeline**:
- First commit: [date]
- Latest commit: [date]
- Total calendar time: [X] days

**Claude Active Hours Estimate**:
Cluster commits into sessions (4-hour windows), estimate 1-4 hours per session based on commit density.

**Value per Claude Hour**:
```
$/Claude Hour = Total Cost Estimate / Claude Active Hours
```

**Speed Multiplier**:
```
Speed = Human Hours / Claude Hours
```

---

## Common Mistakes to Avoid

1. **Counting all lines equally** - A 50K LOC project with 40K lines of scaffolding is NOT a $500K project
2. **Including content as code** - MDX blog posts are writing, not development
3. **Full-valuing test boilerplate** - Test setup/mocking is highly repetitive
4. **Ignoring the scaffold ratio** - Modern frameworks generate 50-80% of typical codebases

## Sanity Checks

Before finalizing, ask:
- Could a competent developer recreate this in [X] weeks? Does the estimate match?
- What % is truly novel vs. "npm install + copy docs"?
- Does the estimate pass the "would I pay this?" test?

A realistic solo web project typically costs **$10K-50K**, not $100K+. Anything higher requires exceptional complexity justification.
