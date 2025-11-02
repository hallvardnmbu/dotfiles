#!/bin/bash

SHOW_FILE="/home/acme/.config/applications/show"
APP_DIR="/usr/share/applications"

if [[ $EUID -ne 0 ]]; then
   echo "Must be run with sudo."
   exit 1
fi

if [[ ! -f $SHOW_FILE ]]; then
    echo "Error: Whitelist file not found at $SHOW_FILE"
    echo "Please create it first, with one app name (like 'firefox') per line."
    exit 1
fi

echo "Updating desktop files."
for file in "$APP_DIR"/*.desktop; do

    if [[ -f "$file" ]]; then
        base_name=$(basename "$file" .desktop)

        if grep -q -x "$base_name" "$SHOW_FILE"; then
            if grep -q "^NoDisplay=true$" "$file"; then
                echo "* showing: $base_name"
                sed -i '/^NoDisplay=true$/d' "$file"
            fi
        else
            if ! grep -q "^NoDisplay=true$" "$file"; then
                echo "* hiding: $base_name"
                echo "NoDisplay=true" >> "$file"
            fi
        fi
    fi
done

update-desktop-database

echo ""
echo "Shown applications:"
grep -L "NoDisplay=true" /usr/share/applications/*.desktop | xargs basename -s .desktop

echo ""
echo "Hidden applications:"
grep -l "NoDisplay=true" /usr/share/applications/*.desktop | xargs basename -s .desktop
