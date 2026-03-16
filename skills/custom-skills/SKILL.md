---
name: custom-skills
description: "Internal skill — loads user-defined custom skills from .superpowers/skills/ directory, allowing users to extend or override built-in skills."
---

# Custom Skills

Allow users to define project-specific skills that extend or override built-in ones.

## When to Use

**At session start**, after loading config. If `.superpowers.yml` has `custom_skills_dir` set (default: `.superpowers/skills/`), scan that directory for custom skill files.

## How It Works

### Directory Structure

```
.superpowers/
  skills/
    my-deploy-check/
      SKILL.md          # Custom skill definition
    code-style/
      SKILL.md          # Custom skill definition
    brainstorming/
      SKILL.md          # Override built-in brainstorming
```

### Skill Resolution Order

When looking for a skill:
1. **Custom skills directory** (`.superpowers/skills/`) — checked first
2. **Built-in skills** (`skills/`) — fallback

This means a custom skill with the same name as a built-in skill **overrides** it for this project.

### Custom Skill Format

Same format as built-in skills:

```markdown
---
name: my-deploy-check
description: "Run deployment checks before finishing a branch"
---

# My Deploy Check

## When to Use

After all tests pass, before finishing-a-development-branch.

## The Process

1. Run `npm run build` to verify production build
2. Run `npm run lint` to check code style
3. Check bundle size hasn't increased by more than 10%
...
```

### Registering Custom Skills

Custom skills are automatically discovered. No registration needed — just create the directory and SKILL.md file.

To reference a custom skill from other skills or pipeline config:

```yaml
# In .superpowers.yml
pipeline:
  - brainstorming
  - writing-plans
  - using-git-worktrees
  - subagent-driven-development
  - my-deploy-check              # Custom skill injected into pipeline
  - finishing-a-development-branch
```

### Best Practices

- **Don't duplicate built-in skills.** Only override if you need different behavior.
- **Keep custom skills focused.** One skill per concern.
- **Version control custom skills.** They're project-specific, so commit them.
- **Use the `writing-skills` skill** to create well-structured custom skills.

## Error Handling

| Scenario | Behavior |
|----------|----------|
| `custom_skills_dir` doesn't exist | Warn: "Custom skills directory '{path}' not found — skipping." Don't create it automatically. |
| Directory exists but is empty | Silently continue — no warning needed. |
| SKILL.md is missing in a subdirectory | Warn: "Custom skill '{dir}' has no SKILL.md — skipping." |
| SKILL.md has no frontmatter (no `name` or `description`) | Warn: "Custom skill '{dir}/SKILL.md' is missing frontmatter — skipping." |
| Custom skill name conflicts with built-in | Custom wins (override). Log: "Custom skill '{name}' overrides built-in skill." |
| Pipeline references a custom skill that doesn't exist | Warn: "Pipeline references skill '{name}' which was not found in built-in or custom skills — skipping stage." |

## Integration

**Called by:**
- loading-config — discovers custom skills at session start
- using-superpowers — includes custom skills in skill resolution
