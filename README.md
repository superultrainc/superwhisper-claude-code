# Superwhisper Claude Code Plugin

Voice integration between Superwhisper and Claude Code. When Claude Code completes a task, Superwhisper shows a notification so you can respond by voice.

## Installation

```bash
curl -fsSL https://superwhisper.com/install/claude-code | bash
```

Then restart Claude Code to activate.

To verify installation:
```bash
cat ~/.claude/settings.json | grep superwhisper
```

### Manual install

```bash
claude plugin marketplace add superultrainc/superwhisper-claude-code
claude plugin install superwhisper
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

1. You start Claude Code on a task
2. When the agent needs you Superwhisper opens over any other windows or workflows
3. You respond by voice, typing or selecting an option
4. The agent starts working away again

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
