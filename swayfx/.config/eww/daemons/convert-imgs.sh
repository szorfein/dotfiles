#!/usr/bin/env sh

set -o errexit

IMGS_DIR="$HOME/images/"
IMGS="holy.jpg jinx.png"

convert_img() {
    img="$1"
    if [ ! -f "/tmp/$img" ]; then
        magick "$IMGS_DIR$img" -resize 640x480^ -gravity Center -extent 640x480 "/tmp/$img" > /dev/null 2>&1 &
        printf '%s\n' "Added /tmp/$img"
    else
        printf '%s\n' "Alrealy exist /tmp/$img"
    fi
}

for img in $IMGS; do
    convert_img "$img"
done
