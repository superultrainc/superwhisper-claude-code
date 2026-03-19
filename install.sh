#!/bin/bash
set -e

claude plugin marketplace add superultrainc/superwhisper-claude-code
claude plugin install superwhisper

echo "Superwhisper plugin installed. Restart Claude Code to activate."
