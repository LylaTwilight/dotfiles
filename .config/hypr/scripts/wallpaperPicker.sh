#!/bin/bash

# Check if rofi is already running
if pgrep -x "rofi" > /dev/null; then
    hyprctl notify 3 2000 "rgb(C62E2E)" "fontsize:24" " Rofi is already running"
    exit 1
fi

# The path of the wallpapers directory
wallpaper_dir="$HOME/.wallpapers"

# finds images with webp type (because sometimes i find images with the extension .jpg for example but it's in fact a webp image)
webps=$(find "$wallpaper_dir" -type f -exec file --mime-type {} + | grep "image/webp" | cut -d: -f1)

# convert webp images to png
# and moves them to webp_images directory
if [[ -n "$webps" ]]; then
	while read webp; do
		png="${webp%.*}.png"
		magick "$webp" "$png"
		rm "$webp"
	done <<< "$webps"
fi

# regex to filter images
regex=".*\.\(jpg\|png\|jpeg\)"

# finds all images in the wallpaper directory and it's subdirectories excluding webp_images which contain the webp images so it doesn't convert them to png every time the script is launched
filenames=$(find "$wallpaper_dir" -type f -regex $regex -printf "%P\n")

# make rofi display the icons for the wallpapers
entries=""
while IFS= read -r filename; do
    entries+="$filename\x00icon\x1f$wallpaper_dir/$filename\n"
done <<< "$filenames"
entries="${entries%\\n}"

# runs rofi
picked=$(echo -e "$entries" | rofi -dmenu -theme wallpaperPicker.rasi)

# check if you selected a wallpaper and apply it using swww
if [[ -n "$picked" ]]; then

	swww img "$wallpaper_dir/$picked" --transition-fps 200 --transition-type random --transition-duration 2 

	hyprctl notify 5 2000 "rgb(84DE8E)" "fontsize:24 ✨ Wallpaper changed to $picked"
    # uncomment this if you want wallpaper picker to change the background of hyprlock
    # NOTE that this script changes only the first "path" in hyprlock.conf 
    # source $HOME/.config/hypr/scripts/changeHyprlockBG.sh
fi
