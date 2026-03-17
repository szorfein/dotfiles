#!/usr/bin/env sh

set -o errexit

ICON=""
DATE=$(date '+%Y%m%d-%H%M%S')
NAME="screenshot-$DATE.jpg"
DID=666

grim "$HOME/$NAME"

dunstify -u low -i "$ICON" "Screenshot" "Saved at ~/$NAME" -r "$DID"
