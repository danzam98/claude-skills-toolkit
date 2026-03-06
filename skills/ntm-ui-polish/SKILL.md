---
name: ntm-ui-polish
description: UI/UX refinement pass for world-class visual polish
version: 1.0.0
author: Daniel Fischer
category: design
tags: ["ntm", "multi-agent", "swarm", "ui", "ux", "polish"]
---
# UI/UX Polish Pass

I still think there are strong opportunities to enhance the UI/UX look and feel and to make everything work better and be more intuitive, user-friendly, visually appealing, polished, slick, and world class in terms of following UI/UX best practices like those used by Stripe, don't you agree?

And I want you to carefully consider desktop UI/UX and mobile UI/UX separately while doing this and hyper-optimize for both separately to play to the specifics of each modality.

I'm looking for true world-class visual appeal, polish, slickness, etc. that makes people gasp at how stunning and perfect it is in every way. Use ultrathink.

## Areas to Focus

### Visual Polish
- Consistent spacing and alignment
- Smooth transitions and animations (respecting prefers-reduced-motion)
- Proper color contrast (WCAG AA minimum)
- Typography hierarchy and rhythm
- Subtle shadows and depth
- Gradient accents where appropriate

### Desktop Optimizations
- Hover states on all interactive elements
- Keyboard navigation and shortcuts
- Wide viewport layouts that use space well
- Multi-column layouts where appropriate
- Command palette (Cmd+K) integration

### Mobile Optimizations
- Touch targets minimum 44x44px
- Thumb-friendly bottom navigation
- Swipe gestures where intuitive
- No hover-dependent functionality
- Fast tap response (no 300ms delay)
- Appropriate viewport scaling

### Micro-interactions
- Button press feedback
- Loading states
- Success/error animations
- Scroll-triggered reveals
- Focus ring transitions

Reference the design system in globals.css for tokens.

## When to Use

- After core features are implemented
- For final polish before release
- When UI feels "good enough" but not great

## Tips

- Focus on one area at a time
- Test on both desktop and mobile
- Respect accessibility requirements
