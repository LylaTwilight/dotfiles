#!/bin/bash

# The path of the wallpapers directory
wallpaper_dir="$HOME/.wallpapers"

# check if the webp images directory
# webp images aren't supported as an icon in rofi
if [[ ! -d "$wallpaper_dir/webp_images" ]]; then
	mkdir -p "$wallpaper_dir/webp_images"
fi

# finds images with webp type
webps=$(find "$wallpaper_dir" -path $wallpaper_dir/webp_images -prune -o -type f -exec file --mime-type {} + | grep "image/webp" | cut -d: -f1)

# convert webp images to png
# and moves them to webp_images directory
if [[ -n "$webps" ]]; then
	while read webp; do
		png="${webp%.*}.png"
		echo "Converting $webp to $png"
		magick "$webp" "$png"
		mv "$webp" "$wallpaper_dir/webp_images"
	done <<< "$webps"
fi

# regex to filter images
regex=".*\.\(jpg\|png\|jpeg\)"

# finds all images in the wallpaper directory and it's subdirectories excluding webp_images which contain the webp images so it doesn't convert them to png every time the script is launched
filenames=$(find "$wallpaper_dir" -path $wallpaper_dir/webp_images -prune -o -type f -regex $regex -printf "%P\n")

# make rofi display the icons for the wallpapers
entries=""
while IFS= read -r filename; do
    entries+="$filename\x00icon\x1f$wallpaper_dir/$filename\n"
done <<< "$filenames"
entries="${entries%\\n}"

# runs rofi
 rofi=$(echo -e "$entries" | rofi -dmenu -theme $HOME/.config/rofi/wallpaper-selector.rasi)

# check if you selected a wallpaper and apply it using swww
if [[ -n "$rofi" ]]; then

	wal -i "$wallpaper_dir/$rofi" -n 

	swww img "$wallpaper_dir/$rofi" --transition-fps 200 --transition-type random --transition-duration 2 

	hyprctl notify 5 2000 "rgb(84DE8E)" "fontsize:24 ✨ Wallpaper changed to $rofi"
	
else
	hyprctl notify -1 1000 "rgb(729FCF)" "fontsize:24 💀 KILL YOURSELF"

fi
