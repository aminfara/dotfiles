#!/bin/sh

# 1. Fetch the relative path from the RSS feed
relative_path=$(
  curl "https://www.bing.com/HPImageArchive.aspx?format=rss&n=1" | xmllint --xpath "/rss/channel/item/link/text()" -
)

# 2. Extract the base image name and append the UHD resolution suffix
# This replaces standard dimensions (like _1920x1080.jpg) cleanly with _UHD.jpg
urlpath=$(echo "$relative_path" | sed -E 's/_[0-9]+x[0-9]+\.jpg/_UHD.jpg/')

# 3. Download the native 4K asset
curl -s -o ~/Pictures/Wallpapers/bing-daily-wallpaper.jpg "https://www.bing.com$urlpath"

# hyprctl hyprpaper wallpaper ", /tmp/bing-wallpaper-tmp.jpg, cover"
