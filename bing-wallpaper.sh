#!/usr/bin/env bash
# set -x

PICTURE_DIR="$HOME/Pictures/bing-wallpapers/"

mkdir -p $PICTURE_DIR

urls=( $(curl -s http://www.bing.com | sed -En 's/.*<link rel="preload" href="(.*)" as="image" id="preloadBg".*/\1/p' | cut -d\" -f1) )

for p in ${urls[@]}; do
    echo $p
    filename=$(echo $p | sed  -En "s|/th\?id=(.*\.jpg)&amp;rf.+|\1|p")
    if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $filename ..."
        curl -Lo "$PICTURE_DIR/$filename" "http://www.bing.com/${p}"
    else
        echo "Skipping: $filename ..."
    fi
done
