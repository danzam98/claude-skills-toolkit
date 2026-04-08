# Quick Reference

## Commands

### Running Tests

```bash
# Full test suite (headless)
bun run test:e2e

# Against production
bun run test:e2e:prod

# Specific test file
bun run test:e2e e2e/tests/dashboard.spec.ts

# Specific test by name
bun run test:e2e -g "health score"

# Headed mode (visible browser)
bun run test:e2e --headed

# Debug mode (step through)
bun run test:e2e --debug

# With UI (interactive)
bun run test:e2e --ui
```

### Reports

```bash
# View HTML report
bunx playwright show-report

# Generate report after failed run
bunx playwright show-report playwright-report
```

### Test User Management

```bash
# Provision all test users
bun scripts/provision-e2e-test-users.ts

# Provision specific user
bun scripts/provision-e2e-test-users.ts --user=primary

# Reset user to seed state
bun scripts/reset-e2e-test-user.ts --user=primary

# Dry run (no changes)
bun scripts/provision-e2e-test-users.ts --dry-run
```

### Debugging

```bash
# Run with trace (creates trace.zip on failure)
bun run test:e2e --trace on

# Open trace viewer
bunx playwright show-trace test-results/trace.zip

# Run with video recording
bun run test:e2e --video on

# Slow motion (500ms between actions)
bun run test:e2e --slowmo 500
```

---

## Configuration Snippets

### playwright.config.ts (Production)

```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  timeout: 60000,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  fullyParallel: true,

  use: {
    baseURL: process.env.E2E_BASE_URL || 'https://your-app.com',
    trace: 'retain-on-failure',
    screenshot: 'on',
    video: 'retain-on-failure',
    actionTimeout: 30000,
    navigationTimeout: 60000,
  },

  reporter: [
    ['list'],
    ['html', { open: 'never' }],
    ['json', { outputFile: 'test-results/results.json' }],
  ],

  projects: [
    {
      name: 'auth-setup',
      testMatch: /auth\.global-setup\.ts/,
    },
    {
      name: 'chromium',
      dependencies: ['auth-setup'],
      use: {
        ...devices['Desktop Chrome'],
        storageState: '.auth/user.json',
      },
    },
    {
      name: 'mobile',
      dependencies: ['auth-setup'],
      use: {
        ...devices['iPhone 14'],
        storageState: '.auth/user.json',
      },
    },
  ],
});
```

### package.json Scripts

```json
{
  "scripts": {
    "test:e2e": "playwright test --config=playwright.config.ts",
    "test:e2e:prod": "E2E_BASE_URL=https://your-app.com playwright test --config=playwright.production.config.ts",
    "test:e2e:headed": "playwright test --headed",
    "test:e2e:debug": "playwright test --debug",
    "test:e2e:ui": "playwright test --ui",
    "test:e2e:report": "playwright show-report"
  }
}
```

### .env.local Template

```bash
# Test User Credentials
E2E_TEST_EMAIL=e2e-test@app.test
E2E_TEST_PASSWORD=your-password-here
E2E_FREE_EMAIL=e2e-free@app.test
E2E_FREE_PASSWORD=your-password-here

# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
SUPABASE_SERVICE_ROLE_KEY=eyJ...  # For provisioning only

# AI Analysis (optional)
GEMINI_API_KEY=your-api-key
AI_ANALYSIS_ENABLED=true
AI_ANALYSIS_BUDGET_CENTS=100

# Base URL
E2E_BASE_URL=http://localhost:3000
```

### .gitignore Additions

```gitignore
# E2E Testing
.auth/
test-results/
playwright-report/
playwright/.cache/

# Keep structure
!.auth/.gitkeep
!test-results/.gitkeep
```

---

## File Structure

```
e2e/
├── auth.global-setup.ts       # Auth once, save state
├── playwright.config.ts       # Config
│
├── pages/                     # Page Objects
│   ├── BasePage.ts
│   ├── DashboardPage.ts
│   ├── SettingsPage.ts
│   └── index.ts               # Re-exports
│
├── fixtures/                  # Test data & config
│   ├── test-users.ts          # User definitions
│   ├── seed-data.ts           # Pre-seeded data
│   ├── pages.ts               # Page object fixtures
│   └── devices.ts             # Viewport configs
│
├── utils/                     # Utilities
│   ├── console-monitor.ts     # Console capture
│   ├── ai-analyzer.ts         # Gemini integration
│   ├── cost-tracker.ts        # API cost tracking
│   └── screenshot-manager.ts  # Screenshot utilities
│
└── tests/                     # Test specs
    ├── dashboard.spec.ts
    ├── settings.spec.ts
    └── onboarding.spec.ts

scripts/
├── provision-e2e-test-users.ts
├── reset-e2e-test-user.ts
└── validate-e2e.sh
```

---

## Common Patterns

### Wait for Element

```typescript
// Wait for element to be visible
await expect(page.getByTestId('widget')).toBeVisible();

// Wait with custom timeout
await expect(page.getByTestId('widget')).toBeVisible({ timeout: 10000 });

// Wait for element to disappear
await expect(page.locator('.spinner')).toBeHidden();

// Wait for network idle
await page.waitForLoadState('networkidle');
```

### Robust Locators

```typescript
// Prefer role-based (accessible)
page.getByRole('button', { name: 'Submit' })
page.getByRole('heading', { name: /dashboard/i })

// Label-based (forms)
page.getByLabel('Email')

// Fallback: test ID
page.getByTestId('health-score')

// Multi-strategy (comma = OR)
page.locator('[data-testid="submit"], button:text("Submit")').first()
```

### Form Interaction

```typescript
// Fill input
await page.getByLabel('Email').fill('test@example.com');

// Select dropdown
await page.getByLabel('Country').selectOption('US');

// Check checkbox
await page.getByLabel('I agree').check();

// Click button
await page.getByRole('button', { name: 'Submit' }).click();
```

### Assertions

```typescript
// URL
await expect(page).toHaveURL(/dashboard/);

// Text content
await expect(page.getByTestId('title')).toContainText('Welcome');

// Visibility
await expect(page.getByTestId('widget')).toBeVisible();
await expect(page.getByTestId('spinner')).toBeHidden();

// Count
await expect(page.locator('tr')).toHaveCount(10);

// Attribute
await expect(page.getByRole('button')).toBeEnabled();
await expect(page.getByRole('button')).toBeDisabled();
```

### Navigation

```typescript
// Go to URL
await page.goto('/dashboard');

// Wait for navigation
await page.waitForURL(/settings/);

// Click and wait for navigation
await Promise.all([
  page.waitForNavigation(),
  page.getByRole('link', { name: 'Settings' }).click(),
]);
```

---

## Troubleshooting

### Test Times Out

```typescript
// Increase timeout for slow pages
test('slow page', async ({ page }) => {
  test.setTimeout(120000);  // 2 minutes
  await page.goto('/slow-page');
});
```

### Element Not Found

```typescript
// Debug: pause and inspect
await page.pause();

// Debug: take screenshot
await page.screenshot({ path: 'debug.png' });

// Debug: print HTML
console.log(await page.content());
```

### Auth Session Expired

```bash
# Delete cached auth and re-run
rm -rf .auth/
bun run test:e2e
```

### Flaky Tests

```typescript
// Add retry for flaky test
test('flaky test', async ({ page }) => {
  test.describe.configure({ retries: 3 });
  // ...
});

// Or use expect with retry
await expect(async () => {
  const count = await page.locator('tr').count();
  expect(count).toBeGreaterThan(0);
}).toPass({ timeout: 10000 });
```

### CI-Specific Issues

```typescript
// Slow down for CI
if (process.env.CI) {
  test.setTimeout(120000);
}

// Single worker in CI (more stable)
// In playwright.config.ts:
workers: process.env.CI ? 1 : undefined,
```

---

## Checklist: New Test

- [ ] Extend Page Object or create new one
- [ ] Use role-based locators where possible
- [ ] Add `await expect(...).toBeVisible()` after navigation
- [ ] Check console errors: `expect(page.getConsoleErrors()).toHaveLength(0)`
- [ ] Add screenshot at key steps (if using AI analysis)
- [ ] Test both desktop and mobile viewports
- [ ] Verify test passes in headless mode
- [ ] Run full suite before committing

---

## Checklist: New Test User

- [ ] Define in `e2e/fixtures/test-users.ts`
- [ ] Add env vars: `E2E_*_EMAIL`, `E2E_*_PASSWORD`
- [ ] Create seed data in `e2e/fixtures/seed-data.ts`
- [ ] Run provisioning: `bun scripts/provision-e2e-test-users.ts --user=<type>`
- [ ] Add credentials to `.env.local`
- [ ] Add to CI secrets

---

## Environment Variables Reference

| Variable | Required | Description |
|----------|----------|-------------|
| `E2E_TEST_EMAIL` | Yes | Primary test user email |
| `E2E_TEST_PASSWORD` | Yes | Primary test user password |
| `NEXT_PUBLIC_SUPABASE_URL` | Yes | Supabase project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Yes | Supabase anon key |
| `SUPABASE_SERVICE_ROLE_KEY` | Provisioning | Admin key for user creation |
| `GEMINI_API_KEY` | Optional | For AI visual analysis |
| `AI_ANALYSIS_ENABLED` | Optional | Toggle AI analysis (default: true) |
| `AI_ANALYSIS_BUDGET_CENTS` | Optional | Max AI spend per run (default: 100) |
| `E2E_BASE_URL` | Optional | Override test target URL |
| `CI` | Auto | Set by CI systems, enables CI-specific config |
