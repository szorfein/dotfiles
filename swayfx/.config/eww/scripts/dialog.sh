#!/usr/bin/env sh

set -o errexit

focus=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused == true) | .name')
screen=0

search_screen() {
    poutputs=$(wlr-randr --json | jq -r '.[] | select(.enabled == true) | .name')
    s=0
    for mon in $poutputs; do
        if [ "$mon" = "$focus" ]; then
            echo "get $mon $focus $s"
            screen="$s"
        fi
        s=$((s + 1))
    done
}

open() {
    search_screen
    eww open "$1" --id dl-"$1-$focus" --arg monitor="$screen" &
    wait
    eww update "$1"-visible=true
}

close() {
    eww close dl-"$1-$focus" &
    wait
    eww update "$1"-visible=false
}

test_dialog() {
    is_visible=$(eww get "$1"-visible)
    if $is_visible; then
        return 0
    else
        return 1
    fi
}

if [ "$1" = "open" ]; then
    if ! test_dialog "$2"; then
        open "$2"
    fi
fi

if [ "$1" = "close" ]; then
    if test_dialog "$2"; then
        close "$2"
    fi
fi

if [ "$1" = "toggle" ]; then
    if test_dialog "$2"; then
        close "$2"
    else
        open "$2"
    fi
fi
