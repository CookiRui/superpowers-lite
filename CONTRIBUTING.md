# Contributing to Superpowers Lite

Thanks for your interest in contributing!

## Getting Started

1. Fork the repository
2. Clone your fork
3. Create a branch for your changes

## Adding a New Skill

Use the `writing-skills` skill as a guide. Every skill needs:

- `skills/<skill-name>/SKILL.md` with frontmatter (`name`, `description`)
- Clear "When to Use" section
- A checklist or process flow
- Integration section (what skills it works with)

## Adding Config Options

If your change adds a new `.superpowers.yml` option:

1. Add the option with a default to `.superpowers.yml` (the example file)
2. Update `skills/loading-config/SKILL.md` defaults table
3. Update `skills/config-validation/SKILL.md` validation rules
4. Update `docs/configuration-guide.md`

## Submitting Changes

1. Test your changes in a real project with the plugin installed locally
2. Update `CHANGELOG.md`
3. Submit a PR with a clear description

## Code Style

- Skills are written in Markdown
- Keep instructions clear and actionable
- Follow existing patterns in other skills
- Prefer explicit over implicit

## Issues

Report bugs and feature requests at https://github.com/CookiRui/superpowers-lite/issues
