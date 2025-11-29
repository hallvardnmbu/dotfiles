#!/bin/bash

sleep 0.05

STATUS=$(playerctl status 2>/dev/null)
if [ "$STATUS" = "Playing" ]; then
    playerctl play-pause
elif [ "$STATUS" = "Paused" ]; then
    playerctl play-pause
else
    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=spotify --file-forwarding com.spotify.Client @@u %U @@
fi
