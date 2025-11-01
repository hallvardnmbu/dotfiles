#!/bin/bash

playerctl status 2>/dev/null | grep -q "Playing" && exit 1
pactl list sinks | grep -q "RUNNING" && exit 1

exit 0
