# Idea Wizard

Generate and evaluate improvement ideas for a project, feature, or codebase.

## What This Does

Structured brainstorming and evaluation process:
1. Generate 30 ideas considering robustness, performance, UX, reliability
2. Evaluate each idea on implementation effort, user impact, complexity tradeoff
3. Winnow to top 5, ordered best to worst
4. Explain rationale for each top idea
5. Optionally implement the top idea

## How to Use

- **General improvements:** `/idea-wizard`
- **Specific focus:** `/idea-wizard <topic>` (e.g., "performance", "UX", "security")
- **For a feature:** `/idea-wizard "how to improve checkout flow"`

## Instructions

When this skill is invoked:

### Step 1: Generate 30 Ideas (Divergent Thinking)

Brainstorm 30 distinct ideas across these categories:
- **Robustness:** Error handling, resilience, fault tolerance
- **Performance:** Speed, efficiency, scalability
- **User Experience:** Usability, accessibility, delight
- **Reliability:** Testing, monitoring, observability
- **Security:** Auth, data protection, vulnerability fixes
- **Maintainability:** Code quality, documentation, architecture
- **Features:** New capabilities, enhancements, integrations

Don't filter yet — quantity over quality in this phase.

### Step 2: Evaluate Each Idea

For each of the 30 ideas, score on:
- **Implementation Effort:** 1 (trivial) to 5 (major)
- **User Impact:** 1 (negligible) to 5 (transformative)
- **Complexity Tradeoff:** Does benefit justify added complexity?

Calculate a rough priority score: `Impact / Effort`

### Step 3: Winnow to Top 5

Sort by priority score and select top 5, considering:
- Highest impact-to-effort ratio
- Strategic alignment with project goals
- Balance across different categories
- Feasibility with current resources

Order best to worst.

### Step 4: Explain Rationale

For each of the top 5, provide:
- **What:** Brief description of the idea
- **Why:** Expected benefit and impact
- **How:** High-level implementation approach
- **Tradeoffs:** What are we giving up or complicating?
- **Effort estimate:** Hours/days/weeks

### Step 5: Offer to Implement

Ask user if they want to:
1. Implement the top idea now
2. Create a plan for multiple ideas
3. Export ideas to a project roadmap
4. Generate more ideas in a specific category

## Example Output

```
=== Idea Wizard: Improving Checkout Flow ===

Generated 30 ideas, evaluated, top 5 below:

1. **Add one-click checkout for returning customers**
   Why: 80% of customers are repeat users, reduce friction from 5 clicks to 1
   How: Store payment method + shipping, show "Buy Now" button
   Tradeoffs: Slightly more complex auth flow, need PCI compliance review
   Effort: 2 days
   Impact: 5/5 (could increase conversion 15-20%)

2. **Implement optimistic UI updates**
   Why: Checkout feels slow, users abandon during loading states
   How: Update UI immediately, rollback on error
   Tradeoffs: More complex error handling, need idempotency
   Effort: 1 day
   Impact: 4/5 (better perceived performance)

3. **Add cart abandonment email recovery**
   Why: 70% cart abandonment rate, recover 10-15% with email
   How: Queue job on cart update, send email after 1 hour
   Tradeoffs: Email infrastructure, unsubscribe management
   Effort: 3 days
   Impact: 4/5 (direct revenue increase)

4. **Show real-time inventory on product pages**
   Why: Users add to cart then find out item is out of stock
   How: WebSocket connection for live inventory updates
   Tradeoffs: More server load, caching complexity
   Effort: 2 days
   Impact: 3/5 (reduces frustration, fewer abandoned carts)

5. **Add guest checkout option**
   Why: 30% of users abandon when forced to create account
   How: Allow purchase without account, optionally create after
   Tradeoffs: Need to handle anonymous users, order tracking
   Effort: 2 days
   Impact: 3/5 (removes friction, increases conversion)

Should I implement #1 now, create a plan for multiple, or explore more ideas?
```

## Related Skills

- **/plan-review** — Review implementation plans for ideas
- **/prd** — Turn ideas into structured Product Requirements Documents
