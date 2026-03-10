---
name: ntm-ui-polish
description: UI/UX refinement pass for world-class visual polish
version: 2.0.0
author: Daniel Fischer
category: design
tags: ["ntm", "multi-agent", "swarm", "ui", "ux", "polish"]
---
# UI/UX Polish Pass

Enhance the UI/UX look and feel to make everything more intuitive, user-friendly, visually appealing, polished, and world-class — following the best practices of top-tier products like Stripe, Linear, and Vercel.

Consider desktop and mobile separately. Hyper-optimize for both modalities. Use ultrathink.

I'm looking for true world-class visual appeal, polish, slickness, etc. that makes people gasp at how stunning and perfect it is in every way.

**Before starting:** Read AGENTS.md to understand the design system for this project — color palette, typography, spacing tokens, and any brand guidelines. Apply those values throughout; do not invent new ones.

## Areas to Focus

### Visual Polish
- Consistent spacing and alignment across all elements
- Smooth transitions and animations (always respect `prefers-reduced-motion`)
- Proper color contrast (WCAG AA minimum; AA for body text, AA for UI elements)
- Typography hierarchy and vertical rhythm
- Subtle shadows and depth cues
- Appropriate use of brand colors and accent tones per AGENTS.md

### Desktop Optimizations
- Hover states on all interactive elements
- Keyboard navigation completeness and visible focus rings
- Wide viewport layouts that use space efficiently
- Multi-column layouts where content warrants it
- Command palette or keyboard shortcut integration where appropriate

### Mobile Optimizations
- Touch targets minimum 44×44px
- Thumb-friendly placement of primary actions
- Swipe gestures where intuitive
- No functionality that requires hover
- Fast tap response (eliminate 300ms delay)
- Appropriate viewport scaling and safe area insets

### Micro-interactions
- Button and control press feedback
- Loading and skeleton states
- Success/error confirmation animations
- Scroll-triggered reveals (with reduced-motion fallback)
- Focus ring transitions

## When to Use

- After core features are implemented
- For final polish before stakeholder review or release
- When the UI is functional but not yet delightful

## Tips

- Work one area at a time — polish breadth-first before depth
- Test on both desktop and mobile viewports before closing
- Never override AGENTS.md brand colors with invented ones
- Respect accessibility requirements — polish should never reduce usability
