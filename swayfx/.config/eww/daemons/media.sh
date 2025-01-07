#!/usr/bin/env bash

#set -o errexit

# Script inspiration
# https://gitlab.com/xPMo/dotfiles.cli/-/blob/dots/.local/lib/waybar/playerctl.sh
# https://github.com/elenapan/dotfiles/blob/master/config/eww/scripts/daemons/media.sh

# Cover Art work on:
# https://youtube.com
# https://odysee.com
#
# Not on (lack of metadata)
# invidious
PID_FILE="/tmp/daemon-media"
PID=$$

if [ -f "$PID_FILE" ] ; then
    OLD_PID=$(cat <"$PID_FILE")
    echo "old pid found $OLD_PID"
    kill -9 "$OLD_PID"
    rm -r "$PID_FILE"
fi

if pgrep -f "playerctl --follow metadata" ; then
    pgrep -f "playerctl --follow metadata" | xargs kill
fi

echo "$PID" >"$PID_FILE"

#while :; do 
    # always prefer inotify or any mechanism to check change over sleep
    #sleep 5
#done
# requires playerctl>=2.0
# Add non-space character ":" before each parameter to prevent 'read' from skipping over them
playerctl --follow metadata --format $':{{emoji(status)}}\t:{{position}}\t:{{mpris:length}}\t:{{playerName}}\t:{{mpris:artUrl}}\t:{{duration(position)}}\t:{{duration(mpris:length)}}' | while read -r playing position length name arturl hpos hlen; do

# All vars are prefixed with ':'
playing=${playing:1}
position=${position:1}
length=${length:1}
name=${name:1}
#artist=${artist:1}
#title=${title:1}
arturl=${arturl:1}
hpos=${hpos:1}
hlen=${hlen:1}

# artist and title can contain a lot of characters...
artist=$(playerctl metadata --format '{{ trunc(artist, 10) }}')
title=$(playerctl metadata --format '{{ trunc(title, 10) }}')

if [ "$name" = "brave" ] ; then
    arturl="${arturl#file://}"
fi

if [ -z "$arturl" ] ; then
    if [ "$name" = "mpd" ] ; then
        echo "check for mpd..."
    fi
    arturl="" # default cover
fi

#echo "{\"playing\":\"$playing\",\"position\":\"$position\",\"length\":\"$length\",\"name\":\"$name\",\"artist\":\"$artist\",\"title\":\"$title\",\"arturl\":\"$arturl\",\"hpos\":\"$hpos\",\"hlen\":\"$hlen\"}"
eww update media="{
    \"playing\":\"$playing\",
    \"position\":\"$position\",
    \"length\":\"$length\",
    \"name\":\"$name\",
    \"artist\":\"$artist\",
    \"title\":\"$title\",
    \"arturl\":\"$arturl\",
    \"hpos\":\"$hpos\",
    \"hlen\":\"$hlen\"
}"
done

