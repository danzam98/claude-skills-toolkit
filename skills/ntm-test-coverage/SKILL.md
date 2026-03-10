---
name: ntm-test-coverage
description: Audit and expand test coverage with comprehensive logging
version: 2.0.0
author: Daniel Fischer
category: testing
tags: ["ntm", "multi-agent", "swarm", "testing", "coverage"]
---
# Test Coverage Audit

Audit the current state of test coverage and create a comprehensive set of beads for any gaps. Prefer real implementations over mocks. Include detailed logging throughout. Use ultrathink.

Start by reading AGENTS.md to understand what test frameworks and tooling this project uses — do not assume Vitest, Jest, Playwright, or any specific framework.

## Step 1: Discover the Test Setup

Check AGENTS.md and the project's `package.json` (or equivalent) to identify:
- Unit test framework and runner (Vitest, Jest, pytest, etc.)
- Integration/E2E test framework (Playwright, Cypress, etc.)
- Any API or backend test tooling
- Existing test directories and conventions

```bash
# Find existing tests:
./robot files test --json   # if ./robot is available
# or explore the test directories described in AGENTS.md
```

## Step 2: Audit Coverage Areas

Assess coverage across the layers that exist in **this project** (not all will apply):

### Unit Tests
- [ ] Core utility and helper functions
- [ ] Data transformation and validation logic
- [ ] Business logic and domain rules
- [ ] Edge cases and error paths

### Component / UI Tests (if applicable)
- [ ] Components render correctly with varied props
- [ ] Accessibility attributes present (labels, roles, focus)
- [ ] Error and empty states handled
- [ ] User interactions behave as expected

### Integration / E2E Tests (if applicable)
- [ ] Critical user journeys end-to-end
- [ ] Form submissions and validation
- [ ] Navigation and routing
- [ ] Authentication flows (if any)
- [ ] Mobile and responsive breakpoints

### API / Backend Tests (if applicable)
- [ ] All API endpoints return correct responses
- [ ] Authentication and authorization enforced
- [ ] Error responses have correct status codes
- [ ] Rate limiting and edge cases handled

## Step 3: Create Beads for Gaps

For each area with missing coverage, create a bead:

```bash
br create "Tests: <area description>" --type task --priority 2
```

Include in each bead description:
- Specific functions, components, or flows to test
- Edge cases to cover
- Expected log output format
- Acceptance criteria (what "done" looks like)

## When to Use

- Before major releases
- When coverage feels incomplete
- After significant new features
- When bugs are found that tests should have caught

## Tips

- Prefer real implementations over mocks — test the actual behavior
- Include detailed logging for easier debugging when tests fail
- Group test beads under a parent test-coverage epic for organization
- Check AGENTS.md for any project-specific testing conventions
