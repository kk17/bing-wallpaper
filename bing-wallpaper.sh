#!/usr/bin/env bash
# set -x

PICTURE_DIR="$HOME/Pictures/bing-wallpapers/"

mkdir -p $PICTURE_DIR

# g_img={url: "http:\/\/s.cn.bing.net\/az\/hprichbg\/rb\/PuttyBeach_ZH-CN8972640560_1920x1080.jpg",
# urls=( $(curl -s http://cn.bing.com | \
#     grep -Eo "g_img={url: \".*?\"" | \
#     sed -e "s/g_img={url: \"\([^']*\)\".*/\1/" | \
#     sed -e "s/\\\//g") )
urls=( $(curl -s http://www.bing.com | \
    sed -En "s/.*g_img={url: *[\"'](.*jpg)[\"'],id.*/\1/p" | \
    sed -e "s/\\\//g") )

for p in ${urls[@]}; do
    echo $p
    filename=$(echo $p|sed -e "s/.*\/\(.*\)/\1/")
    if [ ! -f $PICTURE_DIR/$filename ]; then
        echo "Downloading: $filename ..."
        curl -Lo "$PICTURE_DIR/$filename" "http://cn.bing.com/${p}"
    else
        echo "Skipping: $filename ..."
    fi
done

# curl -s http://cn.bing.com | grep -Eo "g_img={url:'.*?'" | sed -e "s/g_img={url:'\([^']*\)'.*/\1/" | sed -e "s/\\\//g"
# curl -s http://cn.bing.com | grep -Eo "g_img={url: \".*?\"" | sed -e "s/g_img={url:'\([^']*\)'.*/\1/" | sed -e "s/\\\//g"
# curl -s http://cn.bing.com | sed -En "s/.*g_img={url: *[\"'](http.*jpg)[\"'],id.*/\1/p"
