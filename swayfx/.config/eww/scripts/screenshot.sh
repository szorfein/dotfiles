#!/usr/bin/env sh

set -o errexit

ICON=""
DATE=$(date '+%Y%m%d-%H%M%S')
NAME="screenshot-$DATE.jpg"
DIR="$HOME/documents/rices"
DID=666

[ -d "$DIR" ] || mkdir -p "$DIR"

grim "$DIR/$NAME"

dunstify -u low -i "$ICON" "Screenshot" "Saved into $DIR" -r "$DID"
