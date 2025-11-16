#!/usr/bin/env sh

set -o errexit

# Return monitors, for me return only eDP-1
# Can't test myself if it's really work's...
# MONS=$(swaymsg -t get_outputs | jq ".[].name" | tr -d '"')
#swaymsg -t get_outputs | jq -c '.[] | pick(.name, .focused)' | tr -d '"'

# Best? e.g return eDP-1 focused
#MONS=$(swaymsg -t get_outputs -p | grep "^Output" | awk '{print $2,$8}' | tr -d '()')

IS_VISIBLE=$(eww get navbar-visible)

open_widget() {
    if $IS_VISIBLE; then return 0; fi

    mon="$1"
    count="$2"
    eww open bar --id "rb-$mon" --arg monitor="$mon" --arg screen="$count" --screen "$count" &
    wait
    eww update navbar-visible=true &
    wait
}

hide_widget() {
    mon="$1"
    echo "Hidding railbar on $mon..."
    eww close "rb-$mon" &
    wait
    eww update navbar-visible=false &
    wait
}

toggle_widget() {
    if $IS_VISIBLE; then
        hide_widget "$1"
    else
        open_widget "$1" "$2"
    fi
}

while [ $# -gt 0 ]; do
    case "$1" in
    -h | --hide)
        hide_widget "$2"
        shift
        shift
        ;;
    -o | --open)
        open_widget "$2" "$3"
        shift
        shift
        shift
        ;;
    -t | --toggle)
        toggle_widget "$2" "$3"
        shift
        shift
        shift
        ;;
    esac
done
