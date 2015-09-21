#!/usr/bin/env bash

PICTURE_DIR="$HOME/Pictures/bing-wallpapers/"

mkdir -p $PICTURE_DIR

urls=( $(curl -s http://cn.bing.com | \
    grep -Eo "g_img={url:'.*?'" | \
    sed -e "s/g_img={url:'\([^']*\)'.*/\1/" | \
    sed -e "s/\\\//g") )

for p in ${urls[@]}; do
    echo $p
    filename=$(echo $p|sed -e "s/.*\/\(.*\)/\1/")
    if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $filename ..."
        curl -Lo "$PICTURE_DIR/$filename" $p
    else
        echo "Skipping: $filename ..."
    fi
done
