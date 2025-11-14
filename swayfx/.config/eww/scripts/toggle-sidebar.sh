#!/usr/bin/env sh

set -o errexit

trap 'rm /tmp/inwork' EXIT
[ -f /tmp/inwork ] && exit 1

touch /tmp/inwork

# Return monitors, for me return only eDP-1
# Can't test myself if it's really work's...
MONS=$(swaymsg -t get_outputs | jq ".[].name" | tr -d '"')

open_widget() {
    echo "Opening sidebar..."
    count=0
    for mon in $MONS; do
        eww open sidebar --id "sb-$mon" --arg monitor="$mon" --screen "$count"
        count=$((count + 1))
    done
    eww update sidebar-visible=true
}

hide_widget() {
    echo "Hidding sidebar..."
    for mon in $MONS; do
        eww close "sb-$mon"
    done
    eww update sidebar-visible=false
}

toggle_widget() {
    IS_VISIBLE=$(eww get sidebar-visible)
    if $IS_VISIBLE; then
        hide_widget
    else
        open_widget
    fi
}

case "$1" in
-h | --hide) hide_widget ;;
-o | --open) open_widget ;;
-t | --toggle) toggle_widget ;;
esac
