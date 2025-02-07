# Get current wallpaper from swww
swwwData=$(swww query)

# Remove useless info
userWallpaper="${swwwData##*image: }"

# Replace the /home/user with $HOME
currentWallpaper="\$HOME/${userWallpaper#*/*/*/}"
echo $currentWallpaper

# Replace the path of image in hyprlock with the current wallpaper
sed -i "0,\@path = .*@s@path = .*@path = $currentWallpaper@" $HOME/.config/hypr/hyprlock.conf

