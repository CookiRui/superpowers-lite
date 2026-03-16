---
name: metrics-reporting
description: "Internal skill — tracks and reports pipeline metrics (tokens, time, review iterations) across sessions. Enabled via track_metrics in .superpowers.yml."
---

# Metrics & Reporting

Track pipeline performance across sessions for cost awareness and process improvement.

## When to Use

**Automatically when enabled.** Check `.superpowers.yml`:
- `track_metrics: true` — save metrics after each pipeline run
- `track_tokens: true` — track token usage per task

If neither is set, this skill is inactive.

## What's Tracked

### Per-Task Metrics

Saved to `.superpowers/metrics.jsonl` (one JSON line per event):

```json
{
  "type": "task_complete",
  "timestamp": "2026-03-16T10:15:00Z",
  "feature": "payment-system",
  "task_id": 1,
  "task_name": "Database schema",
  "complexity": "complex",
  "mode": "full",
  "duration_seconds": 180,
  "tokens": {
    "implementer": 15000,
    "spec_review": 8000,
    "quality_review": 10000,
    "total": 33000
  },
  "review_iterations": {
    "spec": 1,
    "quality": 2
  },
  "files_changed": 3,
  "lines_added": 120,
  "lines_removed": 15
}
```

### Per-Pipeline Metrics

Saved when the pipeline completes:

```json
{
  "type": "pipeline_complete",
  "timestamp": "2026-03-16T11:00:00Z",
  "feature": "payment-system",
  "mode": "full",
  "preset": "enterprise",
  "total_duration_seconds": 3600,
  "total_tokens": 150000,
  "tasks_completed": 5,
  "tasks_failed": 0,
  "total_review_iterations": 8,
  "stages_completed": ["brainstorming", "writing-plans", "using-git-worktrees", "subagent-driven-development", "finishing-a-development-branch"],
  "outcome": "merged"
}
```

## Pipeline Summary

At the end of each pipeline run, output a summary:

```
Pipeline Summary: payment-system
─────────────────────────────────
Mode:       full (enterprise preset)
Duration:   ~60 minutes
Tasks:      5/5 completed
Tokens:     ~150,000 total
  - Implementation: 80,000 (53%)
  - Reviews:        60,000 (40%)
  - Planning:       10,000 (7%)
Reviews:    8 iterations across 5 tasks
Outcome:    Merged to main
```

## Cross-Session Analysis

Users can review `.superpowers/metrics.jsonl` to understand:
- Average token cost per feature
- Which task types are most expensive
- Review iteration trends (improving or not?)
- Quick-mode vs full-pipeline usage ratio
- Time spent per pipeline stage

## File Location

- `.superpowers/metrics.jsonl` — raw metrics (append-only)
- `.superpowers/token-log.jsonl` — token usage per task (append-only)

Both files should be in `.gitignore` — metrics are local, not shared.

## Integration

**Called by:**
- subagent-driven-development — after each task
- executing-plans — after each task
- finishing-a-development-branch — pipeline summary
- quick-mode — task metrics
