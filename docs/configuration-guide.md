# Configuration Guide

Superpowers Lite is configured via `.superpowers.yml` in your project root. All settings are optional — defaults match the original superpowers behavior.

## Quick Reference

```yaml
# Start from a preset (optional)
preset: startup          # startup | enterprise | learning

# Core settings
mode: auto               # auto | full | quick
tdd: required            # required | recommended | off
auto_commit: true        # true | false
use_worktree: true       # true | false
branch_pattern: "feature/{feature}"

# Reviews
spec_review: true        # true | false
code_review: true        # true | false
review_mode: separate    # separate | combined
skip_review_in_quick_mode: false

# Paths
paths:
  specs: "docs/specs"
  plans: "docs/plans"
  spec_pattern: "{date}-{name}-design.md"
  plan_pattern: "{date}-{name}.md"

# Pipeline
pipeline:
  - brainstorming
  - writing-plans
  - using-git-worktrees
  - subagent-driven-development
  - finishing-a-development-branch

# Advanced
max_review_iterations: 5
track_tokens: false
track_metrics: false
custom_skills_dir: ".superpowers/skills"
```

## Settings in Detail

### `mode`

Controls how the agent routes tasks.

| Value | Behavior |
|-------|----------|
| `auto` (default) | Agent assesses task complexity and picks quick or full pipeline |
| `full` | Always use the full pipeline (brainstorming → spec → plan → execute) |
| `quick` | Always use quick mode (straight to implementation) |

### `tdd`

Controls test-driven development enforcement.

| Value | Behavior |
|-------|----------|
| `required` (default) | Strict TDD. No production code without a failing test. Code written before tests must be deleted. |
| `recommended` | TDD encouraged but not enforced. Pre-test code is not deleted, but tests are still expected. |
| `off` | No TDD requirement. Tests are optional. |

### `review_mode`

Controls how code review works during task execution.

| Value | Behavior |
|-------|----------|
| `separate` (default) | Two review passes: spec compliance first, then code quality. Most thorough. |
| `combined` | Single review pass covering both. Fewer tokens, faster. |

Set `spec_review: false` or `code_review: false` to disable individual review types.

### `paths`

Where design specs and implementation plans are saved.

```yaml
paths:
  specs: "docs/specs"              # Directory for spec documents
  plans: "docs/plans"              # Directory for plan documents
  spec_pattern: "{date}-{name}-design.md"  # Filename pattern
  plan_pattern: "{date}-{name}.md"         # Filename pattern
```

Placeholders:
- `{date}` → `YYYY-MM-DD` (e.g., `2026-03-16`)
- `{name}` → feature name, kebab-case (e.g., `payment-system`)

### `pipeline`

Define which stages run and in what order. Only applies to full mode.

```yaml
# Default
pipeline:
  - brainstorming
  - writing-plans
  - using-git-worktrees
  - subagent-driven-development
  - finishing-a-development-branch
```

Remove stages to skip them:
```yaml
# No worktree, work on current branch
pipeline:
  - brainstorming
  - writing-plans
  - subagent-driven-development
  - finishing-a-development-branch
```

Add custom skills:
```yaml
pipeline:
  - brainstorming
  - writing-plans
  - using-git-worktrees
  - subagent-driven-development
  - my-deploy-check                # custom skill
  - finishing-a-development-branch
```

### `quick_mode`

Hints for auto mode to decide when to use quick mode.

```yaml
quick_mode:
  max_files: 3         # Tasks touching <= this many files
  max_minutes: 15      # Tasks under this estimated duration
  patterns:            # Keywords that suggest quick mode
    - "bug fix"
    - "typo"
    - "rename"
```

### `preset`

Load a named set of defaults. Individual settings override the preset.

| Preset | Mode | TDD | Reviews | Best For |
|--------|------|-----|---------|----------|
| `startup` | auto | recommended | off | Prototyping, solo devs |
| `enterprise` | full | required | separate | Production, teams |
| `learning` | full | required | separate (verbose) | Education, onboarding |

```yaml
preset: startup
tdd: required    # Override just TDD, keep everything else from startup
```

### `skills` (Per-Skill Overrides)

Override settings for specific skills:

```yaml
skills:
  brainstorming:
    max_questions: 5
  subagent-driven-development:
    model_preference: fast
  test-driven-development:
    strict_delete: false
```

### `custom_skills_dir`

Directory for user-defined skills. Skills here are auto-discovered and can override built-in skills.

```yaml
custom_skills_dir: ".superpowers/skills"
```

### Tracking

```yaml
track_tokens: true    # Log token usage to .superpowers/token-log.jsonl
track_metrics: true   # Log pipeline metrics to .superpowers/metrics.jsonl
```

Both files are append-only and should be in `.gitignore`.

## Precedence

When multiple sources define the same setting:

```
User's direct instructions (in chat)
  > .superpowers.yml explicit settings
    > preset defaults
      > global defaults
```

## Generated Files

| File | Purpose | Git? |
|------|---------|------|
| `.superpowers.yml` | User config | Yes — commit it |
| `.superpowers/progress.json` | Interrupt/resume state | No — gitignore |
| `.superpowers/token-log.jsonl` | Token usage log | No — gitignore |
| `.superpowers/metrics.jsonl` | Pipeline metrics | No — gitignore |
| `.superpowers/skills/` | Custom skills | Yes — commit them |
