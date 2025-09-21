#!/bin/sh
# Unified i3 setup script

# Built-in laptop screen
INTERNAL="HDMI-1-0"

# Detect the first connected HDMI output
EXTERNAL=$(xrandr --query | awk '/HDMI-[0-9] connected/{print $1; exit}')

if [ -n "$EXTERNAL" ]; then
    echo "External monitor detected: $EXTERNAL"

    # 1. Configure monitors
    xrandr --output "$INTERNAL" --primary --auto \
           --output "$EXTERNAL" --auto --right-of "$INTERNAL" --rotate left

else
    echo "No external monitor detected."

    #single monitor only mode
    xrandr --output "$INTERNAL" --primary --auto \
           --output HDMI-2 --off \
           --output HDMI-3 --off
fi

