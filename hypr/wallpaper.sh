#!/bin/bash

DIRECTORY="$HOME/.config/wallpapers"

# Time to wait between changes (in seconds)
# 30m = 1800s
SLEEP=1800

while true; do
    FILE=$(find "$DIRECTORY" -type f -name "*.jpg" | shuf -n 1)

    if [ -n "$FILE" ]; then
        hyprctl hyprpaper preload "$FILE"
        hyprctl hyprpaper wallpaper ",$FILE"
    else
        echo "No files found in $DIRECTORY"
    fi

    sleep $SLEEP
done
