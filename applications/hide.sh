#!/bin/bash

SHOW_FILE="/home/acme/.config/applications/show"
LOCATIONS=(
    "/usr/share/applications/"
    "/var/lib/flatpak/exports/share/applications/"
)

if [[ $EUID -ne 0 ]]; then
   echo "Must be run with sudo."
   exit 1
fi

if [[ ! -f $SHOW_FILE ]]; then
    echo "Error: Whitelist file not found at $SHOW_FILE"
    echo "Please create it first, with one app name (like 'firefox') per line."
    exit 1
fi

declare -A WHITELIST
while IFS= read -r line; do
    # Trim whitespace and carriage returns
    clean_line=$(echo "$line" | sed 's/\r$//' | xargs)
    if [[ -n "$clean_line" ]]; then
        WHITELIST["$clean_line"]=1
    fi
done < "$SHOW_FILE"

echo "Loaded ${#WHITELIST[@]} applications to show."
echo "Updating desktop files..."

for location in "${LOCATIONS[@]}"; do
    if [[ ! -d "$location" ]]; then
        continue
    fi

    shopt -s nullglob
    for file in "$location"/*.desktop; do
        if [[ -f "$file" ]]; then
            base_name=$(basename "$file" .desktop)

            # Check if app is in whitelist
            if [[ -n "${WHITELIST[$base_name]}" ]]; then
                if grep -q "^NoDisplay=true" "$file"; then
                    echo "* showing: $base_name"
                    sed -i '/^NoDisplay=/d' "$file"
                fi
            else
                if ! grep -q "^NoDisplay=true" "$file"; then
                    echo "* hiding: $base_name"

                    sed -i '/^NoDisplay=/d' "$file"

                    if grep -q "\[Desktop Entry\]" "$file"; then
                        sed -i '/\[Desktop Entry\]/a NoDisplay=true' "$file"
                    else
                        echo "NoDisplay=true" >> "$file"
                    fi
                fi
            fi
        fi
    done
    shopt -u nullglob

    update-desktop-database "$location"
done

echo "Done."
