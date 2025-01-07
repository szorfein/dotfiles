#!/usr/bin/sh

set -o errexit

#   COVER="~/images/nun.jpg" # default image

# This works when autoplay is true on web browser
# playerctl next isn't usefull
if [ "$1" = "next" ] ; then
    PLY=$(playerctl metadata --format "{{ playerName }}")
    LENGTH=$(playerctl metadata "mpris:length")
    INSEC=$(( $LENGTH / 1000000 ))
    if [ "$PLY" = "brave" ] ; then
        playerctl -p "$PLY" position "$INSEC"
    else
        playerctl -p "$PLY" next
    fi
fi

# Need to convert ms in s with playerctl position
# $0 pos 60000000 - go to position 60
if [ "$1" = "pos" ] ; then
    #echo "script called with $2"
    INSEC=$(( $2 / 1000000 ))
    #echo "convert $INSEC"
    playerctl position "$INSEC"
fi
