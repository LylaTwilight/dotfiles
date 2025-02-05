#!/bin/bash

# Check if rofi is already running
if pgrep -x "hyprpicker" &> /dev/null; then
    hyprctl notify 3 2000 "rgb(C62E2E)" "fontsize:24" " Rofi is already running"
	exit 1
fi

# Run hyprpicker
color=$(hyprpicker --autocopy)

# Check if a color was selected
if [ -n "$color" ]; then
	color=${color#\#}
	hyprctl notify -1 2000 "rgb($color)" "fontsize:24" " #$color"
else
	hyprctl notify 4 2000 "rgb(ffffff)" "fontsize:24" " No color selected"
fi
