#!/usr/bin/env bash
# set -x

PICTURE_DIR="$HOME/Pictures/bing-wallpapers/"

mkdir -p $PICTURE_DIR

urls=( $(curl -s http://www.bing.com | sed -En 's/.*bgImg" src="(.*)/\1/p' | cut -d\" -f1) )

for p in ${urls[@]}; do
    echo $p
    filename=$(echo $p|sed -e "s/.*\/\(.*\)/\1/")
    if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $filename ..."
        curl -Lo "$PICTURE_DIR/$filename" "http://www.bing.com/${p}"
    else
        echo "Skipping: $filename ..."
    fi
done