---
name: ntm-test-coverage
description: Audit and expand test coverage with comprehensive logging
version: 2.1.0
author: Daniel Fischer
category: testing
tags: ["ntm", "multi-agent", "swarm", "testing", "coverage"]
---
# Test Coverage Audit

Test coverage is not optional and cannot be half-assed. Comprehensive, real tests are a mark of professional craftsmanship and deep respect for the codebase, the team, and the users who depend on this software. We take our work seriously. Half-assing is not acceptable.

If we don't have full test coverage, create a comprehensive and granular set of beads for all missing areas with tasks, subtasks, and dependency structure overlaid with detailed comments.

**Prefer real implementations over mocks.** Tests that mock everything prove nothing.

Use ultrathink.

## Step 1: Discover the Test Setup

Check AGENTS.md and the project's package config to identify:
- Unit test framework and runner (Vitest, Jest, pytest, Go test, etc.)
- Integration/E2E test framework (Playwright, Cypress, etc.)
- Any API or backend test tooling (Miniflare, Supertest, etc.)
- Existing test directories and conventions

```bash
./robot files test --json   # if ./robot is available
```

## Step 2: Audit Coverage

Work through each category below. **Skip a category only if it genuinely does not apply to this project's architecture** — and when you skip, document why. Never skip out of laziness or time pressure.

### Unit Tests
- [ ] All utility and helper functions
- [ ] All form validation logic
- [ ] All data transformation and parsing logic
- [ ] Business logic and domain rules
- [ ] Content or data collection transforms (if applicable)
- [ ] Search query parsing (if applicable)
- [ ] Animation variant or UI state logic (if applicable)
- [ ] Edge cases and error paths for all of the above

### Component / UI Tests
*(Skip only if project has no UI components)*
- [ ] All UI components render correctly with varied props
- [ ] Props and configuration handled properly
- [ ] Accessibility attributes present (labels, ARIA roles, focus management)
- [ ] Error states displayed correctly
- [ ] Empty and loading states handled
- [ ] User interactions behave as expected

### E2E / Integration Tests
*(Skip only if project has no browser-facing interface)*
- [ ] Full navigation flow
- [ ] Form submissions (with and without JavaScript)
- [ ] Search functionality (if applicable)
- [ ] Critical user journeys end-to-end
- [ ] Authentication flows (if any)
- [ ] Mobile viewport testing

### API / Backend Tests
*(Skip only if project has no backend or API layer)*
- [ ] All API endpoints return correct responses
- [ ] Authentication and authorization enforced
- [ ] Error responses have correct status codes and response bodies
- [ ] Rate limiting behavior (if applicable)
- [ ] Queue processing and async operations (if applicable)
- [ ] Database operations and edge cases (if applicable)

## Step 3: Create Beads for Gaps

For each area with missing coverage, create a bead:

```bash
br create "Tests: <specific area>" --type task --priority 2
```

Include in each bead description:
- Specific functions, components, or flows to test
- Edge cases to cover
- Expected logging format
- Acceptance criteria (what "done" looks like)

## When to Use

- Before major releases
- When coverage feels incomplete
- After significant new features
- When a bug is found that a test should have caught — that gap must be closed

## Tips

- Prefer real implementations over mocks — test actual behavior, not your assumptions about it
- Include detailed logging for easier debugging when tests fail
- Group test beads under a parent test-coverage epic for organization
- Check AGENTS.md for any project-specific testing conventions or CI requirements
