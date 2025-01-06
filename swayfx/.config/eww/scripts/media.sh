#!/usr/bin/sh

set -o errexit

#   COVER="~/images/nun.jpg" # default image

# This works when autoplay is true on web browser
# playerctl next isn't usefull
if [ "$1" = "next" ] ; then
    PLY=$(playerctl metadata --format "{{ playerName }}")
    if [ "$PLY" = "brave" ] ; then
        playerctl -p "$PLY" position "$TIME_MUSIC_MS"
    else
        playerctl -p "$PLY" next
    fi
fi
