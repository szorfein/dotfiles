#!/usr/bin/sh

# For people reading this script
# Playerctl is a really bad reader...
# command should be duplicated to actual make what we want.
# And i don't talk about all other dependencies for mpv(mpris), mpd (mpris), web and more which can also fail for any other reason...
# (dawn stack)

set -o errexit

WEB="brave"
if command -v librewolf >/dev/null ; then
    WEB="firefox"
elif command -v firefox >/dev/null ; then 
    WEB="firefox"
fi

#   COVER="~/images/nun.jpg" # default image

# This works when autoplay is true on web browser
# playerctl next isn't usefull
if [ "$1" = "next" ] ; then
    PLY=$(playerctl metadata --format "{{ playerName }}")
    #LENGTH=$(playerctl metadata "mpris:length")
    #INSEC=$(( $LENGTH / 1000000 ))
    #if [[ "$PLY" = "brave" || "$PLY" = "firefox" ]] ; then
    #    playerctl -p "$PLY" position "$INSEC"
    #else
    playerctl -p "$PLY" next
    #fi
fi

# Need to convert ms in s with playerctl position
# $0 pos 60000000 - go to position 60
if [ "$1" = "pos" ] ; then
    #echo "script called with $2"
    # need to convert microsecond in second
    TIME="$2"
    LTIME=$(( TIME / 1000000))
    RTIME=$(( TIME % 1000000))
    playerctl position "$LTIME.$RTIME"
fi

pause_ply() {
    echo "playerctl -p $1 pause"
    playerctl -p "$1" pause &
    wait
}

pause_no_web() {
    list_all=$(playerctl --list-all)
    while read -r line; do
        echo "$line"
        [ "$line" = "mpd" ] && pause_ply mpd
        [ "$line" = "mpv" ] && pause_ply mpv
    done <<< "$list_all"
}

pause_no_mpd() {
    list_all=$(playerctl --list-all)
    while read -r line; do
        echo "$line"
        [ "$line" = "firefox" ] && pause_ply firefox
        [ "$line" = "firefox.instance_1_28" ] && pause_ply firefox.instance_1_28
        [ "$line" = "brave" ] && pause_ply brave
        [ "$line" = "mpv" ] && pause_ply mpv
    done <<< "$list_all"
}

play_web() {
    list_all=$(playerctl --list-all)
    while read -r line; do
        echo "$line"
    done <<< "$list_all"
}

if [ "$1" = "web-toggle" ] ; then
    playerctl -p mpd pause || echo "mpd paused"
    playerctl -p mpd pause || echo "mpd paused"
    playerctl -p mpv pause || echo "mpv paused"
    playerctl -p mpv pause || echo "mpv paused"
    playerctl -p "$WEB" play-pause || echo "$WEB can fail"
fi

if [ "$1" = "mpd-toggle" ] ; then
    playerctl -p "$WEB" pause || echo "$WEB pause"
    playerctl -p mpv pause || echo "mpv pause"
    playerctl -p "$WEB" pause || echo "$WEB pause"
    playerctl -p mpv pause || echo "mpv pause"
    playerctl -p mpd play-pause || echo "mpd can fail"
fi

if [ "$1" = "mpv-toggle" ] ; then
    playerctl -p "$WEB" pause || echo "$WEB pause"
    playerctl -p "$WEB" pause || echo "$WEB pause"
    playerctl -p mpd pause || echo "mpd pause"
    playerctl -p mpd pause || echo "mpd pause"
    playerctl -p mpv play-pause || echo "mpv can fail"
fi
