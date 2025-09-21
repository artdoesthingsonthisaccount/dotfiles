#!/bin/sh

CONFIG_SNIPPET="$HOME/.config/i3/workspace-outputs.conf"

# Detect internal laptop monitor
INTERNAL="HDMI-1-0"

# Detect which HDMI is connected
if xrandr --query | grep -q "HDMI-2 connected"; then
    EXTERNAL="HDMI-2"
elif xrandr --query | grep -q "HDMI-3 connected"; then
    EXTERNAL="HDMI-3"
else
    EXTERNAL=""
fi

# Write a config snippet with hard workspace bindings
{
    echo "# Auto-generated workspace → output bindings"
    echo "workspace 1 output $INTERNAL"
    echo "workspace 2 output $INTERNAL"
    echo "workspace 3 output $INTERNAL"
    echo "workspace 4 output $INTERNAL"
    echo "workspace 5 output $INTERNAL"
    if [ -n "$EXTERNAL" ]; then
        echo "workspace 6 output $EXTERNAL"
        echo "workspace 7 output $EXTERNAL"
        echo "workspace 8 output $EXTERNAL"
        echo "workspace 9 output $EXTERNAL"
        echo "workspace 10 output $EXTERNAL"
    fi
} > "$CONFIG_SNIPPET"

# Tell i3 to reload config
i3-msg reload

