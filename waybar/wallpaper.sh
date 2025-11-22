#!/bin/bash

DIRECTORY="$HOME/.config/wallpapers"

FILE=$(find "$DIRECTORY" -type f -name "*.jpg" | shuf -n 1)

hyprctl hyprpaper preload "$FILE"
hyprctl hyprpaper wallpaper ",$FILE"
