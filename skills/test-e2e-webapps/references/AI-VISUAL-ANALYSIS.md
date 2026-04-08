# AI Visual Analysis with Gemini

## Table of Contents
- [Why AI Visual Analysis?](#why-ai-visual-analysis)
- [Setup](#setup)
- [AIAnalyzer Class](#aianalyzer-class)
- [Prompt Engineering](#prompt-engineering)
- [Cost Management](#cost-management)
- [Integration Patterns](#integration-patterns)
- [Result Parsing](#result-parsing)

---

## Why AI Visual Analysis?

Traditional visual regression (pixel diff) fails at:

| Scenario | Pixel Diff | AI Analysis |
|----------|------------|-------------|
| Font rendering difference | FALSE POSITIVE | Ignores |
| Button moved 2px | FALSE POSITIVE | Ignores |
| Text truncated/cut off | MISSES | Catches |
| Wrong icon displayed | MISSES | Catches |
| Poor contrast (a11y) | MISSES | Catches |
| Layout broken on mobile | MISSES | Catches |
| "Looks wrong" to human | MISSES | Catches |

**AI understands semantics.** It answers: "Does this look right?" not "Are pixels identical?"

---

## Setup

### Install Dependencies

```bash
bun add @google/generative-ai
```

### Environment Variables

```bash
# .env.local
GEMINI_API_KEY=your-api-key-here

# Optional: cost controls
AI_ANALYSIS_BUDGET_CENTS=100  # Max spend per test run
AI_ANALYSIS_ENABLED=true      # Toggle AI analysis
```

### Gemini Model Selection

| Model | Cost | Speed | Best For |
|-------|------|-------|----------|
| `gemini-1.5-flash` | ~$0.01/image | Fast | Most tests |
| `gemini-1.5-pro` | ~$0.05/image | Slower | Complex layouts |
| `gemini-2.0-flash` | ~$0.005/image | Fastest | High volume |

---

## AIAnalyzer Class

```typescript
// e2e/utils/ai-analyzer.ts
import { GoogleGenerativeAI, type GenerativeModel } from '@google/generative-ai';
import * as fs from 'fs';
import * as path from 'path';

export type IssueSeverity = 'critical' | 'major' | 'minor' | 'info';
export type IssueCategory = 'layout' | 'accessibility' | 'content' | 'mobile' | 'performance' | 'ux';

export interface VisualIssue {
  severity: IssueSeverity;
  category: IssueCategory;
  description: string;
  location?: string;  // e.g., "top-right corner", "navigation bar"
  suggestion?: string;
}

export interface AnalysisResult {
  assessment: 'pass' | 'warning' | 'fail';
  confidence: number;  // 0-100
  issues: VisualIssue[];
  summary: string;
  rawResponse?: string;
}

export interface AnalysisOptions {
  focus?: string;  // e.g., "dashboard", "checkout flow"
  expectedElements?: string[];  // e.g., ["health score gauge", "positions table"]
  viewport?: 'desktop' | 'mobile' | 'tablet';
  previousScreenshot?: string;  // For comparison
  customPrompt?: string;
}

export class AIAnalyzer {
  private model: GenerativeModel;
  private costTracker: CostTracker;

  constructor(apiKey: string, modelName = 'gemini-1.5-flash') {
    const genAI = new GoogleGenerativeAI(apiKey);
    this.model = genAI.getGenerativeModel({ model: modelName });
    this.costTracker = new CostTracker();
  }

  async analyze(
    screenshotPath: string,
    options: AnalysisOptions = {}
  ): Promise<AnalysisResult> {
    // Check budget before proceeding
    if (!this.costTracker.canProceed()) {
      return this.createSkippedResult('Budget exceeded');
    }

    const imageData = fs.readFileSync(screenshotPath);
    const base64Image = imageData.toString('base64');
    const mimeType = this.getMimeType(screenshotPath);

    const prompt = this.buildPrompt(options);

    try {
      const result = await this.model.generateContent([
        { text: prompt },
        {
          inlineData: {
            mimeType,
            data: base64Image,
          },
        },
      ]);

      const response = result.response.text();
      this.costTracker.recordCall(modelName);

      return this.parseResponse(response);
    } catch (error) {
      console.error('AI analysis failed:', error);
      return this.createErrorResult(error);
    }
  }

  private buildPrompt(options: AnalysisOptions): string {
    const base = `Analyze this screenshot of a web application.

You are a senior QA engineer reviewing a ${options.viewport || 'desktop'} screenshot${options.focus ? ` of the ${options.focus}` : ''}.

${options.expectedElements?.length ? `Expected elements that MUST be visible:\n${options.expectedElements.map(e => `- ${e}`).join('\n')}\n` : ''}

Check for:
1. **Layout issues**: Overlapping elements, misalignment, broken grids
2. **Content issues**: Truncated text, missing content, placeholder text visible
3. **Accessibility**: Poor contrast, tiny text, missing visual hierarchy
4. **Mobile issues**: Elements too small to tap, horizontal scroll, content overflow
5. **UX problems**: Confusing layout, hidden CTAs, poor visual feedback

Respond in this exact JSON format:
{
  "assessment": "pass" | "warning" | "fail",
  "confidence": 0-100,
  "summary": "One sentence overall assessment",
  "issues": [
    {
      "severity": "critical" | "major" | "minor" | "info",
      "category": "layout" | "accessibility" | "content" | "mobile" | "ux",
      "description": "What's wrong",
      "location": "Where on the page",
      "suggestion": "How to fix"
    }
  ]
}

Rules:
- "pass": No issues found
- "warning": Minor issues that don't block usage
- "fail": Critical issues that break functionality or accessibility
- Be specific about locations
- Only report real issues, not stylistic preferences`;

    return options.customPrompt || base;
  }

  private parseResponse(response: string): AnalysisResult {
    try {
      // Extract JSON from response (handle markdown code blocks)
      const jsonMatch = response.match(/\{[\s\S]*\}/);
      if (!jsonMatch) {
        throw new Error('No JSON found in response');
      }

      const parsed = JSON.parse(jsonMatch[0]);

      return {
        assessment: parsed.assessment || 'warning',
        confidence: parsed.confidence || 50,
        issues: parsed.issues || [],
        summary: parsed.summary || 'Analysis complete',
        rawResponse: response,
      };
    } catch (error) {
      console.error('Failed to parse AI response:', error);
      return {
        assessment: 'warning',
        confidence: 0,
        issues: [],
        summary: 'Failed to parse AI response',
        rawResponse: response,
      };
    }
  }

  private getMimeType(filePath: string): string {
    const ext = path.extname(filePath).toLowerCase();
    const mimeTypes: Record<string, string> = {
      '.png': 'image/png',
      '.jpg': 'image/jpeg',
      '.jpeg': 'image/jpeg',
      '.webp': 'image/webp',
    };
    return mimeTypes[ext] || 'image/png';
  }

  private createSkippedResult(reason: string): AnalysisResult {
    return {
      assessment: 'pass',
      confidence: 0,
      issues: [],
      summary: `Analysis skipped: ${reason}`,
    };
  }

  private createErrorResult(error: unknown): AnalysisResult {
    return {
      assessment: 'warning',
      confidence: 0,
      issues: [],
      summary: `Analysis error: ${error instanceof Error ? error.message : 'Unknown error'}`,
    };
  }

  getCostSummary(): CostSummary {
    return this.costTracker.getSummary();
  }
}
```

---

## Prompt Engineering

### Focus-Specific Prompts

```typescript
const FOCUSED_PROMPTS: Record<string, string> = {
  dashboard: `Focus on:
- Data visualization clarity (charts, gauges, numbers)
- Information hierarchy (most important metrics prominent)
- Loading states (spinners visible when expected)
- Empty states handled gracefully`,

  checkout: `Focus on:
- Form field visibility and labels
- Error message clarity
- Button prominence (CTA clearly visible)
- Trust signals (security badges, logos)
- Price display accuracy`,

  mobile: `Focus on:
- Touch target size (minimum 44x44px)
- Horizontal overflow (no side scrolling)
- Text readability without zooming
- Navigation accessibility
- Viewport fit (no content cut off)`,

  accessibility: `Focus on WCAG 2.1 AA compliance:
- Color contrast ratios
- Focus indicators visible
- Text sizing (minimum 16px body)
- Alternative text indicators
- Keyboard navigation hints`,
};
```

### Comparison Analysis

```typescript
async analyzeComparison(
  beforePath: string,
  afterPath: string,
  context: string
): Promise<AnalysisResult> {
  const prompt = `Compare these two screenshots (BEFORE and AFTER).
Context: ${context}

Report:
1. Intentional changes (expected based on context)
2. Unintentional changes (regressions)
3. Missing changes (expected but not present)

Focus on functional differences, not pixel-perfect matching.`;

  // Send both images...
}
```

---

## Cost Management

```typescript
// e2e/utils/cost-tracker.ts
export interface CostSummary {
  totalCalls: number;
  estimatedCostCents: number;
  budgetRemainingCents: number;
  callsByModel: Record<string, number>;
}

export class CostTracker {
  private calls: Array<{ model: string; timestamp: number }> = [];
  private budgetCents: number;

  // Approximate costs per call
  private static COST_PER_CALL: Record<string, number> = {
    'gemini-1.5-flash': 1,      // ~$0.01
    'gemini-1.5-pro': 5,        // ~$0.05
    'gemini-2.0-flash': 0.5,    // ~$0.005
  };

  constructor() {
    this.budgetCents = parseInt(process.env.AI_ANALYSIS_BUDGET_CENTS || '100', 10);
  }

  recordCall(model: string): void {
    this.calls.push({ model, timestamp: Date.now() });
  }

  canProceed(): boolean {
    if (process.env.AI_ANALYSIS_ENABLED === 'false') {
      return false;
    }
    return this.getEstimatedCostCents() < this.budgetCents;
  }

  getEstimatedCostCents(): number {
    return this.calls.reduce((total, call) => {
      return total + (CostTracker.COST_PER_CALL[call.model] || 1);
    }, 0);
  }

  getSummary(): CostSummary {
    const callsByModel: Record<string, number> = {};
    for (const call of this.calls) {
      callsByModel[call.model] = (callsByModel[call.model] || 0) + 1;
    }

    return {
      totalCalls: this.calls.length,
      estimatedCostCents: this.getEstimatedCostCents(),
      budgetRemainingCents: this.budgetCents - this.getEstimatedCostCents(),
      callsByModel,
    };
  }
}
```

### Budget Strategies

| Strategy | Budget | When |
|----------|--------|------|
| **Per-run limit** | 100 cents | Default, prevents runaway costs |
| **Per-test limit** | 5 cents | High-volume test suites |
| **Critical only** | 50 cents | Only analyze on test failure |
| **Sampling** | 25 cents | Analyze 1 in 5 screenshots |

```typescript
// Sampling strategy
const shouldAnalyze = Math.random() < 0.2;  // 20% sample
if (shouldAnalyze) {
  await aiAnalyzer.analyze(screenshot);
}
```

---

## Integration Patterns

### In Page Objects

```typescript
// e2e/pages/BasePage.ts
export class BasePage {
  protected aiAnalyzer?: AIAnalyzer;

  constructor(page: Page) {
    if (process.env.GEMINI_API_KEY) {
      this.aiAnalyzer = new AIAnalyzer(process.env.GEMINI_API_KEY);
    }
  }

  async screenshotWithAnalysis(
    name: string,
    options?: AnalysisOptions
  ): Promise<AnalysisResult | null> {
    const path = await this.screenshot(name);

    if (!this.aiAnalyzer) {
      return null;
    }

    return this.aiAnalyzer.analyze(path, options);
  }
}
```

### In Tests

```typescript
test('dashboard visual check', async ({ dashboardPage }) => {
  await dashboardPage.goto();

  const analysis = await dashboardPage.screenshotWithAnalysis('dashboard-loaded', {
    focus: 'dashboard',
    expectedElements: ['health score gauge', 'positions table', 'sync button'],
    viewport: 'desktop',
  });

  if (analysis) {
    // Log for debugging
    console.log('AI Analysis:', analysis.summary);

    // Fail on critical issues
    const criticalIssues = analysis.issues.filter(i => i.severity === 'critical');
    expect(criticalIssues).toHaveLength(0);

    // Warn on major issues (don't fail)
    const majorIssues = analysis.issues.filter(i => i.severity === 'major');
    if (majorIssues.length > 0) {
      console.warn('Major visual issues:', majorIssues);
    }
  }
});
```

### Fixture with AI

```typescript
// e2e/fixtures/ai.ts
import { test as base } from '@playwright/test';
import { AIAnalyzer } from '../utils/ai-analyzer';

type AIFixtures = {
  aiAnalyzer: AIAnalyzer | null;
  analyzeScreenshot: (path: string, options?: AnalysisOptions) => Promise<AnalysisResult | null>;
};

export const test = base.extend<AIFixtures>({
  aiAnalyzer: async ({}, use) => {
    const analyzer = process.env.GEMINI_API_KEY
      ? new AIAnalyzer(process.env.GEMINI_API_KEY)
      : null;
    await use(analyzer);
  },

  analyzeScreenshot: async ({ aiAnalyzer }, use) => {
    const analyze = async (path: string, options?: AnalysisOptions) => {
      if (!aiAnalyzer) return null;
      return aiAnalyzer.analyze(path, options);
    };
    await use(analyze);
  },
});
```

---

## Result Parsing

### Severity Thresholds

```typescript
function shouldFailTest(result: AnalysisResult): boolean {
  // Fail if AI says fail with high confidence
  if (result.assessment === 'fail' && result.confidence >= 70) {
    return true;
  }

  // Fail if any critical issues
  if (result.issues.some(i => i.severity === 'critical')) {
    return true;
  }

  // Fail if multiple major issues
  const majorCount = result.issues.filter(i => i.severity === 'major').length;
  if (majorCount >= 3) {
    return true;
  }

  return false;
}
```

### Structured Assertions

```typescript
// e2e/utils/ai-assertions.ts
export function assertNoVisualIssues(
  result: AnalysisResult,
  options?: {
    ignoreCategories?: IssueCategory[];
    ignoreSeverities?: IssueSeverity[];
    maxMinorIssues?: number;
  }
) {
  const { ignoreCategories = [], ignoreSeverities = ['info'], maxMinorIssues = 5 } = options || {};

  const issues = result.issues.filter(issue => {
    if (ignoreCategories.includes(issue.category)) return false;
    if (ignoreSeverities.includes(issue.severity)) return false;
    return true;
  });

  const critical = issues.filter(i => i.severity === 'critical');
  const major = issues.filter(i => i.severity === 'major');
  const minor = issues.filter(i => i.severity === 'minor');

  if (critical.length > 0) {
    throw new Error(`Critical visual issues:\n${formatIssues(critical)}`);
  }

  if (major.length > 0) {
    throw new Error(`Major visual issues:\n${formatIssues(major)}`);
  }

  if (minor.length > maxMinorIssues) {
    throw new Error(`Too many minor issues (${minor.length} > ${maxMinorIssues}):\n${formatIssues(minor)}`);
  }
}

function formatIssues(issues: VisualIssue[]): string {
  return issues.map(i =>
    `  - [${i.category}] ${i.description}${i.location ? ` (${i.location})` : ''}`
  ).join('\n');
}
```

---

## Reporting Integration

```typescript
// Attach AI analysis to test report
test.afterEach(async ({ aiAnalyzer }, testInfo) => {
  if (aiAnalyzer) {
    const summary = aiAnalyzer.getCostSummary();

    testInfo.annotations.push({
      type: 'ai-cost',
      description: `$${(summary.estimatedCostCents / 100).toFixed(2)} (${summary.totalCalls} calls)`,
    });
  }
});
```

---

## When to Use AI Analysis

| Scenario | Recommendation |
|----------|----------------|
| **Every test run** | No (expensive) |
| **CI on main branch** | Yes (critical path) |
| **PR checks** | Sample 20% |
| **Local development** | On-demand only |
| **After UI changes** | Yes (regression detection) |
| **Visual regression suite** | Yes (primary use case) |
