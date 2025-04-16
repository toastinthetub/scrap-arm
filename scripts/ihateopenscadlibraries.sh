#!/bin/bash

red="\033[0;31m"
yellow="\033[0;33m"
green="\033[0;32m"
reset="\033[0m"

LIBRARIES=("samSCAD")

USER_LIB_PATH="$HOME/.local/share/OpenSCAD/libraries"
ALT_USER_LIB_PATH="$HOME/Documents/OpenSCAD/libraries"
SYS_LIB_PATH="/usr/share/openscad/libraries"

FOUND_PATHS=()

while IFS= read -r line; do
    echo -e "$line"
done < hydrate_yourself_today.txt

echo -e "${red}checking ${reset}${yellow}*probably*${reset}${red} your openscad path${reset}"

for path in "$USER_LIB_PATH" "$ALT_USER_LIB_PATH" "$SYS_LIB_PATH"; do
    if [ -d "$path" ]; then
        echo -e "${green}found library path: $path${reset}"
        FOUND_PATHS+=("$path")
    fi
done

if [ ${#FOUND_PATHS[@]} -eq 0 ]; then
    echo -e "${red}no standard openscad library paths found. create one.${reset}"
    exit 1
fi

echo ""
echo -e "${yellow}checking for specific libraries...${reset}"

for lib in "${LIBRARIES[@]}"; do
    FOUND=0
    for path in "${FOUND_PATHS[@]}"; do
        if [ -d "$path/$lib" ] || [ -f "$path/$lib.scad" ]; then
            echo -e "${green}$lib found in $path${reset}"
            FOUND=1
            break
        fi
    done
    if [ $FOUND -eq 0 ]; then
        echo -e "${red}$lib not found in any known path${reset}"
    fi
done

