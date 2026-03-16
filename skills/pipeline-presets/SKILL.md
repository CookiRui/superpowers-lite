---
name: pipeline-presets
description: "Internal skill — defines named pipeline presets (startup, enterprise, learning) that set sensible defaults for common use cases."
---

# Pipeline Presets

Named configurations for common workflows. Set `preset` in `.superpowers.yml` to use one.

## Available Presets

### `startup` — Fast Iteration

Optimized for speed and cost. Minimal ceremony, quick feedback loops.

```yaml
# Equivalent settings:
mode: auto
tdd: recommended
auto_commit: true
use_worktree: false
spec_review: false
code_review: false
review_mode: combined
skip_review_in_quick_mode: true
max_review_iterations: 2
track_tokens: true
```

**Best for:** Early-stage projects, prototyping, solo developers, hackathons.

**Trade-offs:** Lower review coverage. Relies on developer judgment instead of automated review gates.

### `enterprise` — Full Rigor

Maximum quality gates. Every step enforced, all reviews enabled.

```yaml
# Equivalent settings:
mode: full
tdd: required
auto_commit: true
use_worktree: true
spec_review: true
code_review: true
review_mode: separate
skip_review_in_quick_mode: false
max_review_iterations: 5
track_tokens: true
track_metrics: true
```

**Best for:** Production systems, team projects, regulated industries, critical infrastructure.

**Trade-offs:** Higher token cost, slower iteration. Every task goes through full pipeline regardless of size.

### `learning` — Extra Guidance

Verbose explanations, extra checkpoints, designed for people learning the workflow.

```yaml
# Equivalent settings:
mode: full
tdd: required
auto_commit: true
use_worktree: true
spec_review: true
code_review: true
review_mode: separate
skip_review_in_quick_mode: false
max_review_iterations: 5
skills:
  brainstorming:
    verbose_explanations: true
  test-driven-development:
    explain_why: true
  subagent-driven-development:
    show_review_details: true
```

**Best for:** New users learning superpowers, junior developers, educational contexts.

**Trade-offs:** More verbose output. More tokens used for explanations. Slower but more educational.

## How Presets Work

1. `loading-config` reads `.superpowers.yml`
2. If `preset` is set, load the preset's default values
3. Any explicitly set values in `.superpowers.yml` **override** the preset
4. This means you can use a preset as a base and customize:

```yaml
preset: startup
# Override just the TDD setting — everything else from startup preset
tdd: required
```

## Precedence

```
User's direct instructions > .superpowers.yml explicit settings > preset defaults > global defaults
```
