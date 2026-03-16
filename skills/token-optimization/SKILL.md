---
name: token-optimization
description: "Internal skill — guides smart review skipping and token-efficient behavior based on task complexity. Used by subagent-driven-development and executing-plans."
---

# Token Optimization

Reduce token consumption without sacrificing quality by adapting review depth to task complexity.

## When to Use

**Always active during execution.** This skill provides guidance to `subagent-driven-development` and `executing-plans` for deciding when to skip or simplify reviews.

## Task Complexity Assessment

Before dispatching reviewers, assess the task:

### Trivial Tasks (skip review if configured)

A task is trivial when ALL of these are true:
- Touches 1 file only
- Less than 50 lines changed
- Purely mechanical (rename, config value, import fix, typo)
- No logic changes
- No new public API

**Action:** If `.superpowers.yml` has `skip_review_in_quick_mode: true` and this came from quick-mode, skip both spec and quality review.

### Simple Tasks (reduced review)

A task is simple when:
- Touches 1-2 files
- 50-150 lines changed
- Follows existing patterns
- Clear spec with no ambiguity

**Action:**
- If `review_mode: combined` — single combined review (recommended)
- If `review_mode: separate` — run both but use haiku/fast model for reviewers

### Complex Tasks (full review)

A task is complex when ANY of these are true:
- Touches 3+ files
- Over 150 lines changed
- Creates new interfaces or APIs
- Involves security-sensitive code
- Changes shared infrastructure

**Action:** Full review with most capable model. Never skip.

## Token-Saving Strategies

### 1. Model Selection for Reviews

```
Trivial task → skip review (or haiku if required)
Simple task  → haiku/fast model
Complex task → standard/capable model
```

### 2. Context Minimization

When dispatching reviewers:
- Only include the diff, not entire files
- Only include relevant spec sections, not the whole plan
- Don't include session history or unrelated context

### 3. Review Scope Narrowing

For simple tasks, tell the reviewer to focus on:
- Does it match the spec? (yes/no, no detailed analysis)
- Any obvious bugs? (quick scan)
- Any security issues? (quick scan)

Skip detailed maintainability, naming, and style review for trivial changes.

### 4. Batch Reviews

When multiple simple tasks complete in sequence, batch them:
- Review tasks 1-3 together instead of separately
- One reviewer dispatch instead of three
- Still separate reviews for complex tasks

## Token Tracking

After each task, log token usage to `.superpowers/token-log.jsonl`:

```json
{"task": 1, "name": "Database schema", "complexity": "complex", "tokens": {"implementer": 15000, "spec_review": 8000, "quality_review": 10000, "total": 33000}, "timestamp": "2026-03-16T10:15:00Z"}
{"task": 2, "name": "Fix typo in README", "complexity": "trivial", "tokens": {"implementer": 2000, "review": "skipped", "total": 2000}, "timestamp": "2026-03-16T10:20:00Z"}
```

At pipeline completion, summarize:

```
Token Usage Summary:
- Total: 85,000 tokens across 5 tasks
- Reviews: 45,000 tokens (53%)
- Implementation: 40,000 tokens (47%)
- Saved by optimization: ~20,000 tokens (2 trivial tasks skipped review)
```

## Configuration

From `.superpowers.yml`:
- `skip_review_in_quick_mode: true` — skip reviews for quick-mode tasks
- `review_mode: combined` — single pass instead of two
- `code_review: false` — skip code quality review entirely
- `spec_review: false` — skip spec compliance review entirely

## Integration

**Used by:**
- subagent-driven-development — before dispatching reviewers
- executing-plans — before review checkpoints
- quick-mode — when deciding review depth
