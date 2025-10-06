#!/usr/bin/env sh

set -o errexit

DATE=$(date '+%Y%m%d-%H%M%S')
NAME="screenshot-$DATE.jpg"

grim "$HOME/$NAME"

dunstify -u low -i "" "Screenshot" "Saved at ~/$NAME"
