#!/usr/bin/env sh

set -o errexit

# Return monitors, for me return only eDP-1
# Can't test myself if it's really work's...
MONS=$(swaymsg -t get_outputs | jq ".[].name" | tr -d '"')
#swaymsg -t get_outputs | jq -c '.[] | pick(.name, .focused)' | tr -d '"'

# Best? e.g return eDP-1 focused
#MONS=$(swaymsg -t get_outputs -p | grep "^Output" | awk '{print $2,$8}' | tr -d '()')

open_widget() {
    echo "Opening railbar..."
    count=0
    for mon in $MONS; do
        eww open bar --id "rb-$mon" --arg monitor="$mon" --screen "$count"
        count=$((count + 1))
    done
    eww update navbar-visible=true
}

# TODO: Close only on screen focus ?
hide_widget() {
    echo "Hidding railbar..."
    for mon in $MONS; do
        eww close "rb-$mon"
    done
    eww update navbar-visible=false
}

toggle_widget() {
    IS_VISIBLE=$(eww get navbar-visible)
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
