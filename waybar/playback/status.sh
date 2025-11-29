#!/bin/bash

sleep 0.05

STATUS=$(playerctl status 2>/dev/null)
if [ "$STATUS" = "Playing" ]; then
    TEXT="♫"
    TOOLTIP="$(playerctl metadata title)\n$(playerctl metadata artist)"
elif [ "$STATUS" = "Paused" ]; then
    TEXT="𝄽 "
    TOOLTIP="$(playerctl metadata title)\n$(playerctl metadata artist)"
else
    TEXT="𝄽 "
    TOOLTIP="Silence...\nClick me."
fi

echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}"
