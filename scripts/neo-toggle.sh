#!/bin/bash

STATE_FILE="$HOME/.cache/previous-layout"
NEO=2

# Get current active index (0-based)
CURRENT=$(gdbus call --session --dest org.Cinnamon --object-path /org/Cinnamon --method org.Cinnamon.Eval \
'imports.ui.keyboardManager.getInputSourceManager()._currentSource.index' | \
sed -n "s/.*(true, '\([0-9]*\)').*/\1/p")

if [ "$CURRENT" = "$NEO" ]; then
    # Already on layout 3 → go back to previous
    if [ -f "$STATE_FILE" ]; then
        PREV=$(cat "$STATE_FILE")
        gdbus call --session --dest org.Cinnamon --object-path /org/Cinnamon --method org.Cinnamon.Eval \
        "imports.ui.keyboardManager.getInputSourceManager().activateInputSourceIndex($PREV)" >/dev/null
    else
        gdbus call --session --dest org.Cinnamon --object-path /org/Cinnamon --method org.Cinnamon.Eval \
        'imports.ui.keyboardManager.getInputSourceManager().activateInputSourceIndex(0)' >/dev/null
    fi
else
    # Remember current and switch to layout 3
    echo "$CURRENT" > "$STATE_FILE"
    gdbus call --session --dest org.Cinnamon --object-path /org/Cinnamon --method org.Cinnamon.Eval \
    "imports.ui.keyboardManager.getInputSourceManager().activateInputSourceIndex($NEO)" >/dev/null
fi
