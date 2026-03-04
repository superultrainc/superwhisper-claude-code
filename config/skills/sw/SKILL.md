---
name: superwhisper
description: Toggle Superwhisper agent integration (on/off/toggle)
args: on|off or empty to toggle
---

Run this bash command exactly. The argument is: $ARGUMENTS

```bash
h=$(echo -n "$PWD" | md5 -q 2>/dev/null || echo -n "$PWD" | md5sum | cut -d' ' -f1)
f="/tmp/superwhisper-agent/disabled-$h"
mkdir -p /tmp/superwhisper-agent
case "$1" in
  on)  rm -f "$f"; echo "Superwhisper: ON" ;;
  off) touch "$f"; echo "Superwhisper: OFF" ;;
  *)   [ -f "$f" ] && { rm -f "$f"; echo "Superwhisper: ON"; } || { touch "$f"; echo "Superwhisper: OFF"; } ;;
esac
```

Report the single-line output to the user. Nothing else.
