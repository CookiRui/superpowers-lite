---
name: progress-tracking
description: "Persist and resume task progress across sessions. Saves state to .superpowers/progress.json so interrupted work can continue in a new session."
---

# Progress Tracking (Interrupt/Resume)

Persist pipeline and task progress so work survives session interruptions.

## When to Use

**Automatically during execution.** This skill is used by `subagent-driven-development` and `executing-plans` to save progress after each task completes.

**At session start.** Check for existing progress and offer to resume.

## The Process

### Saving Progress

After each significant milestone, update `.superpowers/progress.json`:

```json
{
  "version": 1,
  "feature": "payment-system",
  "started_at": "2026-03-16T10:00:00Z",
  "updated_at": "2026-03-16T10:45:00Z",
  "pipeline_stage": "subagent-driven-development",
  "mode": "full",
  "config": {
    "spec_path": "docs/specs/2026-03-16-payment-system-design.md",
    "plan_path": "docs/plans/2026-03-16-payment-system.md",
    "branch": "feature/payment-system",
    "worktree_path": ".worktrees/payment-system"
  },
  "tasks": [
    {
      "id": 1,
      "name": "Database schema",
      "status": "completed",
      "commit_sha": "abc1234",
      "completed_at": "2026-03-16T10:15:00Z"
    },
    {
      "id": 2,
      "name": "API endpoints",
      "status": "completed",
      "commit_sha": "def5678",
      "completed_at": "2026-03-16T10:30:00Z"
    },
    {
      "id": 3,
      "name": "Payment processing",
      "status": "in_progress",
      "started_at": "2026-03-16T10:35:00Z",
      "review_feedback": null
    },
    {
      "id": 4,
      "name": "Webhook handlers",
      "status": "pending"
    },
    {
      "id": 5,
      "name": "Integration tests",
      "status": "pending"
    }
  ]
}
```

### Resuming Progress

At session start, if `.superpowers/progress.json` exists:

1. **Read the progress file**
2. **Show status summary to user:**

```
Found interrupted work: "payment-system"
- Pipeline stage: subagent-driven-development
- Branch: feature/payment-system
- Progress: 2/5 tasks completed, 1 in progress
- Last updated: 45 minutes ago

Options:
1. Resume from where we left off
2. Start over (discard progress)
3. Ignore (work on something else)
```

3. **If resuming:**
   - Switch to the correct branch/worktree
   - Read the plan file
   - Skip completed tasks
   - Resume the in-progress task (or restart it if state is unclear)
   - Continue with remaining tasks

4. **If starting over:**
   - Delete `.superpowers/progress.json`
   - Proceed normally

### When to Save

Save progress at these points:
- Pipeline stage transition (brainstorming → writing-plans → etc.)
- Task status change (pending → in_progress → completed)
- After each successful commit
- When review feedback is received

### Checklist

1. **Check for existing progress** at session start
2. **Offer resume/restart/ignore** if progress exists
3. **Save progress** after each milestone during execution
4. **Clean up** progress file when pipeline completes (all tasks done + finishing skill)

## File Location

Progress is saved to `.superpowers/progress.json` in the project root.

**Important:** Add `.superpowers/` to `.gitignore` — progress state is local, not shared.

## Integration

**Used by:**
- subagent-driven-development — saves task progress
- executing-plans — saves task progress
- finishing-a-development-branch — cleans up progress file on completion

**Triggered by:**
- using-superpowers — checks for existing progress at session start
