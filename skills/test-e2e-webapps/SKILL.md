---
name: test-e2e-webapps
description: >-
  E2E testing for Next.js + Playwright + Supabase. OAuth bypass via test users, Page Objects,
  console monitoring. Use when: E2E, Playwright setup, test user provisioning, visual regression.
---

# E2E Testing for Next.js Webapps

> **Core Problem Solved:** Test production SaaS apps with Google OAuth in automated, headless environments by creating special test users with email/password auth that bypass OAuth entirely.

> **Stack:** Next.js 16 + Playwright + Supabase Auth + Gemini AI (visual analysis)

## Quick Start

```bash
# 1. Install Playwright
bun add -D @playwright/test && bunx playwright install chromium

# 2. Create test user in Supabase (bypasses Google OAuth)
bun scripts/provision-e2e-test-users.ts --user=primary

# 3. Run tests against production
E2E_TEST_EMAIL=test@app.test E2E_TEST_PASSWORD=xxx bun run test:e2e:prod
```

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              E2E TESTING ARCHITECTURE                            │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   1. AUTH BYPASS (Supabase Test Users)                                          │
│   ════════════════════════════════════                                          │
│   Test users with email/password ──► Sign in via Supabase Auth (not Google)     │
│   ✓ No CAPTCHA  ✓ No OAuth redirects  ✓ Works in headless CI                    │
│                                                                                 │
│   2. STORAGE STATE REUSE                                                        │
│   ══════════════════════                                                        │
│   Global Setup → Auth once → Save to .auth/user.json → Reuse in all tests       │
│                                                                                 │
│   3. PAGE OBJECT MODEL                                                          │
│   ════════════════════                                                          │
│   BasePage → DashboardPage, SettingsPage, etc. → Encapsulate locators + actions │
│                                                                                 │
│   4. CONSOLE MONITORING                                                         │
│   ═════════════════════                                                         │
│   Capture: runtime errors, network failures, React warnings, hydration issues   │
│                                                                                 │
│   5. AI VISUAL ANALYSIS (Optional)                                              │
│   ═════════════════════════════════                                             │
│   Screenshots → Gemini Vision → Structured issues (layout, a11y, mobile)        │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## The Google OAuth Bypass

**Problem:** Google actively blocks automated logins (CAPTCHA, headless detection).

**Solution:** Create test users with email/password auth in Supabase—same app, different auth method.

```typescript
// Sign in via Supabase (NOT Google OAuth)
const { data, error } = await supabase.auth.signInWithPassword({
  email: process.env.E2E_TEST_EMAIL,
  password: process.env.E2E_TEST_PASSWORD,
});

// Inject session cookies into browser context
await context.addCookies([
  { name: 'sb-access-token', value: data.session.access_token, domain: 'your.supabase.co', ... },
  { name: 'sb-refresh-token', value: data.session.refresh_token, ... },
]);
```

**Why `.test` TLD?** IANA-reserved, never resolves—test emails can't leak to real inboxes.

**Deep dive:** [AUTHENTICATION.md](references/AUTHENTICATION.md)

---

## Workflow

### Phase 1: Setup
- [ ] Install Playwright and configure for production testing
- [ ] Create test user provisioning script (Supabase Admin API)
- [ ] Set up global auth setup with storage state reuse
- [ ] Create 3-5 test user tiers (free, pro, premium, fresh, admin)

### Phase 2: Implementation
- [ ] Create BasePage class with common utilities
- [ ] Build Page Objects for critical pages (Dashboard, Settings, etc.)
- [ ] Add console error monitoring (attach to page.on('console'))
- [ ] Implement screenshot capture at key test steps

### Phase 3: Enhancement (Optional)
- [ ] Add AI visual analysis with Gemini Vision API
- [ ] Implement cost tracking for AI API usage
- [ ] Generate HTML/JSON reports with embedded screenshots

### Phase 4: CI Integration
- [ ] Add test:e2e script to package.json
- [ ] Configure GitHub Actions workflow
- [ ] Upload playwright-report artifacts on failure

---

## Key Configuration

```typescript
// playwright.production.config.ts
export default defineConfig({
  testDir: './e2e',
  timeout: 60000,  // Production needs longer timeouts
  retries: 2,

  use: {
    baseURL: 'https://your-app.com',  // Test against LIVE site
    trace: 'retain-on-failure',
    screenshot: 'on',
    video: 'retain-on-failure',
    actionTimeout: 30000,
    navigationTimeout: 60000,
  },

  projects: [
    {
      name: 'auth-setup',
      testMatch: /auth\.global-setup\.ts/,
    },
    {
      name: 'authenticated',
      dependencies: ['auth-setup'],
      use: {
        storageState: '.auth/user.json',  // Reuse auth
        ...devices['Desktop Chrome'],
      },
    },
  ],
});
```

---

## Test User Tiers

| Type | Email | Tier | Purpose |
|------|-------|------|---------|
| `primary` | `e2e-test@app.test` | Pro | Main tests, full features |
| `free` | `e2e-free@app.test` | Free | Paywall, limitations |
| `premium` | `e2e-premium@app.test` | Premium | All features unlocked |
| `fresh` | `e2e-new@app.test` | None | Onboarding, empty states |
| `admin` | `e2e-admin@app.test` | Admin | Admin panel tests |

Each user has **seed data** for predictable assertions (positions, alerts, settings).

---

## Page Object Pattern

```typescript
// e2e/pages/BasePage.ts
export class BasePage {
  readonly page: Page;
  protected consoleMonitor: ConsoleMonitor;

  constructor(page: Page) {
    this.page = page;
    this.consoleMonitor = new ConsoleMonitor(page);
  }

  async goto(path: string) {
    await this.page.goto(path, { waitUntil: 'networkidle' });
  }

  getByTestId(id: string) { return this.page.getByTestId(id); }
  getByRole(role, opts?) { return this.page.getByRole(role, opts); }

  getConsoleErrors() { return this.consoleMonitor.getErrors(); }
}

// e2e/pages/DashboardPage.ts
export class DashboardPage extends BasePage {
  static readonly PATH = '/portfolio';

  readonly healthScoreWidget = this.page.locator('[data-testid="health-score"]');
  readonly positionsTable = this.page.locator('[data-testid="positions-table"]');

  async goto() { await super.goto(DashboardPage.PATH); }

  async getHealthScore(): Promise<number | null> {
    const text = await this.healthScoreWidget.textContent();
    return text ? parseInt(text.match(/(\d+)/)?.[1] ?? '', 10) : null;
  }
}
```

**Full pattern:** [PAGE-OBJECTS.md](references/PAGE-OBJECTS.md)

---

## Console Error Categories

| Category | Patterns | Action |
|----------|----------|--------|
| `hydration` | `hydrat`, `server.*different.*client` | Fix SSR mismatch |
| `runtime` | `TypeError`, `ReferenceError` | Fix JS error |
| `network` | `net::ERR`, `fetch.*failed` | Check API/CORS |
| `react` | `Warning:`, `useEffect` | Fix hook issue |
| `security` | `CSP`, `Refused to` | Fix CSP policy |

```typescript
// Fail test if unexpected console errors
const errors = dashboard.getConsoleErrors();
const unexpected = errors.filter(e => e.category !== 'deprecation');
expect(unexpected).toHaveLength(0);
```

**Full patterns:** [CONSOLE-MONITORING.md](references/CONSOLE-MONITORING.md)

---

## AI Visual Analysis (Optional)

Send screenshots to Gemini for semantic visual QA:

```typescript
const analysis = await aiAnalyze(screenshotPath, {
  focus: 'dashboard',
  expectedElements: ['health score gauge', 'positions table'],
});

expect(analysis.assessment).not.toBe('fail');
expect(analysis.issues.filter(i => i.severity === 'critical')).toHaveLength(0);
```

**Benefits over pixel-diff:**
- Understands context ("Is button disabled?")
- Catches semantic issues ("Text cut off")
- Identifies a11y problems ("Low contrast")

**Cost:** ~$0.01-0.05 per screenshot. Budget with `CostTracker`.

**Full guide:** [AI-VISUAL-ANALYSIS.md](references/AI-VISUAL-ANALYSIS.md)

---

## Running Tests

```bash
# Local development (against localhost)
bun run test:e2e

# Against production (visible browser for debugging)
bun run test:e2e:prod --headed

# Specific test file
bun run test:e2e e2e/authenticated/dashboard.spec.ts

# With AI analysis
GEMINI_API_KEY=xxx bun run test:e2e:prod

# Debug mode
bun run test:e2e --debug
```

---

## Validation Checklist

- [ ] Test users exist in Supabase with email/password auth
- [ ] Test users have `is_test_user: true` metadata
- [ ] `.auth/user.json` generated on first run
- [ ] Tests pass in headless CI (no Google OAuth prompts)
- [ ] Console errors captured and categorized
- [ ] Screenshots captured at key test steps
- [ ] No flaky tests from timing issues (use proper waits)

---

## Reference Index

### By Task

| I need to... | Read |
|--------------|------|
| **Set up test user auth bypass** | [AUTHENTICATION.md](references/AUTHENTICATION.md) |
| **Implement Page Objects** | [PAGE-OBJECTS.md](references/PAGE-OBJECTS.md) |
| **Monitor console errors** | [CONSOLE-MONITORING.md](references/CONSOLE-MONITORING.md) |
| **Add AI visual analysis** | [AI-VISUAL-ANALYSIS.md](references/AI-VISUAL-ANALYSIS.md) |
| **Generate reports with cost tracking** | [REPORTING.md](references/REPORTING.md) |
| **Quick commands & configuration** | [QUICK-REFERENCE.md](references/QUICK-REFERENCE.md) |

### By Topic

| Topic | Reference |
|-------|-----------|
| Google OAuth bypass, Supabase test users, provisioning scripts | [AUTHENTICATION.md](references/AUTHENTICATION.md) |
| Page Object Model, BasePage, locator strategies, fixtures | [PAGE-OBJECTS.md](references/PAGE-OBJECTS.md) |
| Browser console capture, error categorization, filtering | [CONSOLE-MONITORING.md](references/CONSOLE-MONITORING.md) |
| Gemini Vision API, prompts, cost tracking, result parsing | [AI-VISUAL-ANALYSIS.md](references/AI-VISUAL-ANALYSIS.md) |
| HTML/JSON reports, cost budgets, CI artifacts | [REPORTING.md](references/REPORTING.md) |
| CLI commands, config snippets, troubleshooting | [QUICK-REFERENCE.md](references/QUICK-REFERENCE.md) |

---

## Tools & Scripts

| Tool | Purpose |
|------|---------|
| `scripts/provision-e2e-test-users.ts` | Create test users in Supabase |
| `scripts/reset-e2e-test-user.ts` | Reset user to known seed state |
| `scripts/validate-e2e.sh` | Validate E2E setup |
