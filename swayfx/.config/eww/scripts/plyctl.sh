#!/usr/bin/env sh

set -o errexit

ICON_LOOP=""
ICON_SHUF=""

noti_loop() {
    dunstify -u low -i "$ICON_LOOP" -a "loop" "Loop" "$1" -r 989
}

noti_shuffle() {
    dunstify -u low -i "$ICON_SHUF" -a "shuffle" "Shuffle" "$1" -r 988
}

toggle_loop() {
    curr=$(playerctl loop)
    if [ "$curr" = "None" ]; then
        playerctl -a loop Track
        noti_loop "Change loop to Track"
    elif [ "$curr" = "Track" ]; then
        playerctl -a loop playlist
        noti_loop "Change loop to Playlist"
    else
        playerctl -a loop None
        noti_loop "Disabling loop"
    fi
}

toggle_shuffle() {
    curr=$(playerctl shuffle)
    if [ "$curr" = "On" ]; then
        playerctl -a shuffle Off
        noti_shuffle "Change shuffle to Off"
    else
        playerctl -a shuffle On
        noti_shuffle "Change shuffle to On"
    fi
}

case "$1" in
loop)
    toggle_loop
    shift
    ;;
shuffle)
    toggle_shuffle
    shift
    ;;
esac
