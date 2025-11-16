#!/usr/bin/env sh

set -o errexit

trap 'rm /tmp/inwork' EXIT
[ -f /tmp/inwork ] && exit 1

touch /tmp/inwork

# Return monitors, for me return only eDP-1
# Can't test myself if it's really return all the monitors...
# MONS=$(swaymsg -t get_outputs | jq ".[].name" | tr -d '"')

IS_VISIBLE=$(eww get sidebar-visible)

open_widget() {
    if $IS_VISIBLE; then return 0; fi

    mon="$1"
    count="$2"
    eww open sidebar --id "sb-$mon" --arg monitor="$mon" --arg screen="$count" --screen "$count" &
    wait
    eww update sidebar-visible=true &
    wait
}

hide_widget() {
    mon="$1"
    echo "Hidding sidebar for $mon..."
    eww close "sb-$mon" &
    wait
    eww update sidebar-visible=false &
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
