#!/bin/bash

# Check if hyprpicker is installed
if ! command -v hyprpicker &> /dev/null; then
	hyprctl notify 3 3000 "rgb(FF3333)" "fontsize:24" " Hyprpicker isn't installed"
    exit 1
fi

# Stops hyprpicker from running more than one instance
if pgrep -x "hyprpicker" &> /dev/null; then
	hyprctl notify 4 2000 "rgb(FFFF64)" "fontsize:24" " Don't launch hyprpicker multiple times"
	exit 1
fi

# Run hyprpicker and capture the output
color=$(hyprpicker --autocopy)

# Check if a color was selected
if [ -n "$color" ]; then
	color=${color#\#}
	hyprctl notify -1 2000 "rgb($color)" "fontsize:24" " #$color"
else
	hyprctl notify 4 2000 "rgb(ffffff)" "fontsize:24" " No color selected"
fi
