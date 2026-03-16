# Installing Superpowers Lite for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed
- Git installed

## Installation Steps

### 1. Clone Superpowers Lite

```bash
git clone https://github.com/CookiRui/superpowers-lite.git ~/.config/opencode/superpowers-lite
```

### 2. Register the Plugin

Create a symlink so OpenCode discovers the plugin:

```bash
mkdir -p ~/.config/opencode/plugins
rm -f ~/.config/opencode/plugins/superpowers.js
ln -s ~/.config/opencode/superpowers-lite/.opencode/plugins/superpowers.js ~/.config/opencode/plugins/superpowers.js
```

### 3. Symlink Skills

Create a symlink so OpenCode's native skill tool discovers superpowers skills:

```bash
mkdir -p ~/.config/opencode/skills
rm -rf ~/.config/opencode/skills/superpowers
ln -s ~/.config/opencode/superpowers-lite/skills ~/.config/opencode/skills/superpowers
```

### 4. Restart OpenCode

Restart OpenCode. The plugin will automatically inject superpowers context.

Verify by asking: "do you have superpowers?"

## Configuration

Copy the example config to your project:
```bash
cp ~/.config/opencode/superpowers-lite/.superpowers.yml /path/to/your/project/
```

Edit `.superpowers.yml` to customize. See the [configuration guide](../docs/configuration-guide.md).

## Updating

```bash
cd ~/.config/opencode/superpowers-lite && git pull
```

## Getting Help

- Report issues: https://github.com/CookiRui/superpowers-lite/issues
- Full documentation: https://github.com/CookiRui/superpowers-lite
