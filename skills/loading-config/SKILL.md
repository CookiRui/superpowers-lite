---
name: loading-config
description: "Internal skill — reads .superpowers.yml from project root, validates it, applies presets, loads custom skills, and applies user preferences to all subsequent skill behavior. Invoked automatically at session start."
---

# Loading Configuration

Read and apply user preferences from `.superpowers.yml`.

## When to Use

**Automatically at the start of every session**, before any other skill. This is invoked by the session hook or by the using-superpowers skill.

## The Process

1. **Look for `.superpowers.yml`** in the project root (current working directory)
2. **If found:** Read it, parse YAML
3. **Validate** — invoke `config-validation` to check for errors/warnings
4. **Apply preset** — if `preset` is set, load preset defaults first (see `pipeline-presets`)
5. **Apply explicit settings** — user's explicit settings override preset defaults
6. **Load custom skills** — if `custom_skills_dir` is set, scan for custom skills (see `custom-skills`)
7. **Check for interrupted work** — if `.superpowers/progress.json` exists, offer to resume (see `progress-tracking`)
8. **If not found:** Use all defaults (equivalent to original superpowers behavior)

## Default Values

When `.superpowers.yml` is missing or a setting is omitted, use these defaults:

```yaml
mode: auto
tdd: required
auto_commit: true
use_worktree: true
branch_pattern: "feature/{feature}"
spec_review: true
code_review: true
review_mode: separate
paths:
  specs: "docs/specs"
  plans: "docs/plans"
  spec_pattern: "{date}-{name}-design.md"
  plan_pattern: "{date}-{name}.md"
pipeline:
  - brainstorming
  - writing-plans
  - using-git-worktrees
  - subagent-driven-development
  - finishing-a-development-branch
skip_review_in_quick_mode: false
max_review_iterations: 5
track_tokens: false
track_metrics: false
```

## How Settings Affect Skills

| Setting | Effect |
|---------|--------|
| `mode: quick` | Always offer quick-mode, never auto-trigger brainstorming |
| `mode: full` | Always use full pipeline, never offer quick-mode |
| `mode: auto` | Agent decides based on task complexity |
| `tdd: off` | TDD skill is not invoked; tests are optional |
| `tdd: recommended` | TDD is encouraged but agent won't delete pre-test code |
| `tdd: required` | Original strict TDD behavior |
| `auto_commit: false` | Don't auto-commit; let user control when to commit |
| `use_worktree: false` | Skip worktree creation, work on current branch |
| `spec_review: false` | Skip the spec-document-reviewer loop |
| `code_review: false` | Skip code quality review after tasks |
| `review_mode: combined` | Single review pass using combined-reviewer-prompt |
| `paths.specs` | Where to save spec documents |
| `paths.plans` | Where to save plan documents |
| `pipeline` | Which stages to run and in what order |
| `skip_review_in_quick_mode` | Skip all reviews for quick-mode tasks |
| `track_tokens` | Log token usage to `.superpowers/token-log.jsonl` |
| `track_metrics` | Log pipeline metrics to `.superpowers/metrics.jsonl` |
| `preset` | Load a named preset as base config (startup/enterprise/learning) |
| `skills.<name>.<key>` | Override specific settings per skill |
| `custom_skills_dir` | Directory for user-defined custom skills |

## Preset Resolution

When `preset` is set:
1. Load preset defaults (see `pipeline-presets` skill)
2. Any explicit settings in `.superpowers.yml` **override** preset values
3. Precedence: `user instructions > explicit config > preset > global defaults`

## Per-Skill Overrides

The `skills` key allows overriding settings for specific skills:

```yaml
skills:
  brainstorming:
    max_questions: 5
  subagent-driven-development:
    model_preference: fast
  test-driven-development:
    strict_delete: false
```

When a skill starts, it should check for per-skill overrides and apply them.

## Important

- **User preferences in `.superpowers.yml` take priority** over skill defaults
- **User's direct instructions** (in conversation) take priority over `.superpowers.yml`
- Settings only affect the current project — they are not global
- When mentioning document paths in any skill, use the configured paths, not hardcoded ones
- Validation warnings are shown only when problems are found — no "config OK" noise
