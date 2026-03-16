# Installing Superpowers Lite for Codex

Enable superpowers-lite skills in Codex via native skill discovery. Just clone and symlink.

## Prerequisites

- Git

## Installation

1. **Clone the superpowers-lite repository:**
   ```bash
   git clone https://github.com/CookiRui/superpowers-lite.git ~/.codex/superpowers-lite
   ```

2. **Create the skills symlink:**
   ```bash
   mkdir -p ~/.agents/skills
   ln -s ~/.codex/superpowers-lite/skills ~/.agents/skills/superpowers
   ```

   **Windows (PowerShell):**
   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
   cmd /c mklink /J "$env:USERPROFILE\.agents\skills\superpowers" "$env:USERPROFILE\.codex\superpowers-lite\skills"
   ```

3. **Restart Codex** (quit and relaunch the CLI) to discover the skills.

## Configuration

Copy the example config to your project:
```bash
cp ~/.codex/superpowers-lite/.superpowers.yml /path/to/your/project/
```

Edit `.superpowers.yml` to customize behavior. See the [configuration guide](../docs/configuration-guide.md).

## Updating

```bash
cd ~/.codex/superpowers-lite && git pull
```

Skills update instantly through the symlink.

## Uninstalling

```bash
rm ~/.agents/skills/superpowers
```

Optionally delete the clone: `rm -rf ~/.codex/superpowers-lite`.
