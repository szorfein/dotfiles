#!/usr/bin/env sh

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
    if kill $OLD_PID 2>/dev/null ; then
        echo "old pid found $OLD_PID"
        echo "killing $OLD_PID"
    fi
    rm -r "$PID_FILE"
fi

if PIDS=$(pgrep -f "playerctl --follow metadata") ; then
    kill $PIDS
fi

echo "$PID" >"$PID_FILE"

MPD_MUSIC_DIR="$HOME/musics"

mpd_cover() {
    [ -d "$MPD_MUSIC_DIR" ] || return

    file=$(mpc -f %file% | head -1)
    file_dir="$MPD_MUSIC_DIR/${file%/*}"
    if find=$(find "$file_dir" -regex ".*\.\(jpg\|png\|jpeg\)" | head -1) ; then
        echo "$find"
    fi
}

OLD_SONG=""
#while :; do 
    # always prefer inotify or any mechanism to check change over sleep
    #sleep 5
#done
# requires playerctl>=2.0
# Add non-space character ":" before each parameter to prevent 'read' from skipping over them
#playerctl --follow metadata --format $':{{status}}\t:{{position}}\t:{{mpris:length}}\t:{{playerName}}\t:{{mpris:artUrl}}\t:{{duration(position)}}\t:{{duration(mpris:length)}}' | while read -r playing position length name arturl hpos hlen; do
#playerctl --follow metadata --format $':{{status}}\t:{{position}}\t:{{mpris:length}}\t:{{playerName}}\t:{{mpris:artUrl}}\t:{{duration(position)}}\t:{{duration(mpris:length)}}\t:{{trunc(title, 16)}}\t:{{trunc(artist, 16)}}' | while read -r playing position length name arturl hpos hlen title artist; do
# artist should be placed before title
# artist name and title should not contain any space...
playerctl --follow metadata --format $':{{status}}\t:{{position}}\t:{{mpris:length}}\t:{{playerName}}\t:{{mpris:artUrl}}\t:{{duration(position)}}\t:{{duration(mpris:length)}}\t:{{trunc((markup_escape(artist)),16)}}\t:{{trunc((markup_escape(title)), 16)}}' | while read -r playing position length name arturl hpos hlen artist title; do

# All vars are prefixed with ':'
# in Bash, simply use playing=${playing:1}
playing=$(expr " $playing" : " .\\(.*\\)")
position=$(expr " $position" : " .\\(.*\\)")
length=$(expr " $length" : " .\\(.*\\)")
name=$(expr " $name" : " .\\(.*\\)")
arturl=$(expr " $arturl" : " .\\(.*\\)")
hpos=$(expr " $hpos" : " .\\(.*\\)")
hlen=$(expr " $hlen" : " .\\(.*\\)")
title=$(expr " $title" : " .\\(.*\\)")
artist=$(expr " $artist" : " .\\(.*\\)")

# artist and title can contain a lot of characters...
#artist=$(playerctl metadata --format '{{ trunc(artist, 16) }}')
#title=$(playerctl metadata --format '{{ trunc(title, 16) }}')

if [ "$name" = "brave" ] ; then
    arturl="${arturl#file://}"
fi

if [ "$name" = "mpd" ] ; then
    #if [ "$OLD_SONG" != "$title" ] ; then
        arturl="$(mpd_cover)"
    #fi
fi

# default
[ -z "$arturl" ] && arturl="$HOME/images/nun.jpg"
[ -z "$title" ] && title="N/A"
[ -z "$artist" ] && artist="N/A"
OLD_SONG="$title"
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

web=false
mpd=false
mpv=false
#playerlist=$(playerctl -l)

#if expr "$playerlist" : '.*[brave]' >/dev/null; then
if expr "$name" : '.*[brave]' >/dev/null; then
    status=$(playerctl -p brave status 2>/dev/null)
    if [ "$status" = "Playing" ] ; then
        web=true
    else
        web=false
    fi
fi

#if expr "$playerlist" : '.*[mpd]' >/dev/null; then
if expr "$name" : '.*[mpd]' >/dev/null; then
    status=$(playerctl -p mpd status 2>/dev/null)
    if [ "$status" = "Playing" ] ; then
        mpd=true
    else
        mpd=false
    fi
fi

#if expr "$playerlist" : '.*[mpv]' >/dev/null; then
if expr "$name" : '.*[mpv]' >/dev/null; then
    status=$(playerctl -p mpv status 2>/dev/null)
    if [ "$status" = "Playing" ] ; then
        mpv=true
    else
        mpv=false
    fi
fi

eww update web-active="$web" mpd-active="$mpd" mpv-active="$mpv"
done

