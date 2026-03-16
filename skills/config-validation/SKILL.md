---
name: config-validation
description: "Internal skill — validates .superpowers.yml for invalid keys, values, or conflicts. Called by loading-config at session start."
---

# Config Validation

Validate `.superpowers.yml` and warn the user about problems.

## When to Use

Automatically called by `loading-config` after reading the config file.

## Validation Rules

### Valid Keys

Top-level keys must be one of:
```
mode, quick_mode, tdd, auto_commit, use_worktree, branch_pattern,
spec_review, code_review, review_mode, paths, pipeline,
skip_review_in_quick_mode, max_review_iterations, skills, preset
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
subagent-driven-development, executing-plans,
finishing-a-development-branch
```

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
