# Superwhisper Claude Code Plugin

Voice integration between Superwhisper and Claude Code. When Claude Code completes a task, Superwhisper shows a notification so you can respond by voice.

## Installation

### Option 1: Plugin Marketplace (Recommended)

```bash
# Add the Superwhisper marketplace (one-time)
claude plugin marketplace add github:superultrainc/superwhisper-claude-code

# Install the plugin
claude plugin install superwhisper

# Restart Claude Code to activate
```

To verify installation:
```bash
# Check enabled plugins
cat ~/.claude/settings.json | grep superwhisper
```

### Option 2: Use with --plugin-dir flag

Run Claude Code with the plugin directory:

```bash
claude --plugin-dir /path/to/superwhisper-claude-code
```

Or add it to your shell profile for permanent use:

```bash
# Add to ~/.zshrc or ~/.bashrc
alias claude='claude --plugin-dir /path/to/superwhisper-claude-code'
```

## Plugin Structure

```
superwhisper-claude-code/
├── .claude-plugin/
│   ├── marketplace.json # Marketplace manifest
│   └── plugin.json      # Plugin manifest
├── config/
│   ├── settings.json    # Hook settings for ~/.claude/settings.json
│   ├── statusline.sh    # Custom status line script
│   └── skills/sw/       # Superwhisper toggle skill
├── hooks/
│   ├── hooks.json       # Hooks configuration
│   └── stop.sh          # Called when agent completes
└── README.md
```

## How It Works

1. You give Claude Code a task
2. Claude Code works on the task
3. When the agent finishes, the `Stop` hook fires
4. The hook calls Superwhisper via deeplink
5. Superwhisper shows a notification with the task status
6. You can respond by voice

## Verification

To verify the plugin is loaded, run `/hooks` in Claude Code to see registered hooks.

## Troubleshooting

**Plugin not loading after install:**
- Restart Claude Code after installation
- Check that `superwhisper@superwhisper` appears in `~/.claude/settings.json` under `enabledPlugins`

**Superwhisper not receiving notifications:**
- Ensure Superwhisper is running
- Test deeplink manually: `open "superwhisper://agent-update?agent=test&status=completed&summary=Test"`

**Debug hook execution:**
```bash
claude --debug
# Look for hook-related messages in debug output
```

## Dependencies

- Python 3 (for URL encoding)
- Optional: `jq` for better JSON parsing
