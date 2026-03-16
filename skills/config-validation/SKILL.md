---
name: config-validation
description: "Internal skill — validates .superpowers.yml for invalid keys, values, or conflicts. Called by loading-config at session start."
---

# Config Validation

Validate `.superpowers.yml` and warn the user about problems.

## When to Use

Automatically called by `loading-config` after reading the config file.

## Pre-Validation: YAML Syntax

Before checking keys/values, confirm the file is valid YAML. If parsing fails:
- Report the exact error and line number to the user
- Fall back to all defaults immediately — do NOT attempt partial parsing
- Example: `⚠ .superpowers.yml line 12: mapping values are not allowed here`

## Validation Rules

### Valid Keys

Top-level keys must be one of:
```
mode, quick_mode, tdd, auto_commit, use_worktree, branch_pattern,
spec_review, code_review, review_mode, paths, pipeline,
skip_review_in_quick_mode, max_review_iterations, skills, preset,
track_tokens, track_metrics, custom_skills_dir
```

### Value Validation

| Key | Valid Values |
|-----|-------------|
| `mode` | `auto`, `full`, `quick` |
| `tdd` | `required`, `recommended`, `off` |
| `auto_commit` | `true`, `false` |
| `use_worktree` | `true`, `false` |
| `spec_review` | `true`, `false` |
| `code_review` | `true`, `false` |
| `review_mode` | `separate`, `combined` |
| `skip_review_in_quick_mode` | `true`, `false` |
| `max_review_iterations` | integer, 1-20 |
| `preset` | `startup`, `enterprise`, `learning` |

### Path Validation

- `paths.specs` and `paths.plans` should be valid relative directory paths
- Should not start with `/` or contain `..`
- Pattern placeholders must be `{date}` and/or `{name}`

### Pipeline Validation

Each entry in `pipeline` must be a valid skill name:
```
brainstorming, writing-plans, using-git-worktrees,
project-setup, subagent-driven-development, executing-plans,
finishing-a-development-branch
```
(Custom skill names are also valid if they exist in the custom skills directory)

### Conflict Detection

Warn about conflicting settings:
- `mode: quick` + `pipeline` defined → pipeline is ignored in quick mode
- `tdd: off` + `mode: full` → full pipeline without TDD may produce lower quality
- `spec_review: false` + `code_review: false` → no review at all, are you sure?
- `review_mode: combined` + either review disabled → combined mode has no effect
- `preset` + individual settings → individual settings override preset

## Output

If validation finds problems, report to the user:

```
⚠ .superpowers.yml warnings:
- Unknown key "tddd" (did you mean "tdd"?)
- Invalid value for "mode": "fast" (valid: auto, full, quick)
- Conflict: spec_review and code_review are both disabled — no review will happen

Using defaults for invalid values. Fix warnings in .superpowers.yml to suppress this message.
```

If no problems, say nothing — don't clutter the session with "config is valid" messages.

## "Did You Mean?" Suggestions

For unknown keys, suggest the closest valid key:

| Typo | Suggestion |
|------|-----------|
| `tddd` | `tdd` |
| `mode_` | `mode` |
| `autocommit` | `auto_commit` |
| `worktree` | `use_worktree` |
| `reviews` | `review_mode` |
| `spec_reviews` | `spec_review` |
| `code_reviews` | `code_review` |
| `path` | `paths` |

Use Levenshtein distance ≤ 2 or prefix matching for suggestions.

## Edge Cases

| Scenario | Behavior |
|----------|----------|
| Empty file | Valid YAML (null), use all defaults |
| File contains only comments | Valid YAML (null), use all defaults |
| `pipeline: []` (empty array) | Warn: "Empty pipeline — no stages will run. Using default pipeline." |
| `pipeline` has duplicates | Warn: "Duplicate stage '{name}' in pipeline — will only run once." |
| `preset: startup` + `mode: full` | Not a conflict — explicit `mode` overrides preset's `mode`. No warning. |
| `custom_skills_dir` points to nonexistent dir | Warn: "Custom skills directory '{path}' not found — skipping custom skill loading." |
