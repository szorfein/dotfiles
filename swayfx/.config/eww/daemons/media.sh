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

if PIDS=$(pgrep -f "sh .*media.sh") ; then
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ] ; then
        #echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

#if PIDS=$(pgrep -f "playerctl --follow") ; then
#   kill $PIDS
#fi

mpd_cover() {
    [ -n "$MPD_MUSIC_DIR" ] || return
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
# artist should be placed before title
# artist name and title should not contain any space...
exec playerctl --follow metadata --format $':{{status}}\t:{{position}}\t:{{mpris:length}}\t:{{playerName}}\t:{{mpris:artUrl}}\t:{{duration(position)}}\t:{{duration(mpris:length)}}\t:{{trunc(artist,16)}}@@{{trunc(title, 16)}}' | while read -r playing position length name arturl hpos hlen artist_title; do

# All vars are prefixed with ':'
# in Bash, simply use playing=${playing:1}
playing=$(expr " $playing" : " .\\(.*\\)")
position=$(expr " $position" : " .\\(.*\\)")
length=$(expr " $length" : " .\\(.*\\)")
name=$(expr " $name" : " .\\(.*\\)")
arturl=$(expr " $arturl" : " .\\(.*\\)")
hpos=$(expr " $hpos" : " .\\(.*\\)")
hlen=$(expr " $hlen" : " .\\(.*\\)")
artist=$(expr " ${artist_title%@@*}" : " .\\(.*\\)" | tr -d '"')
title="$(echo ${artist_title#*@@} | tr -d '"')"

# artist and title can contain a lot of characters...
#artist=$(playerctl metadata --format '{{ trunc(artist, 16) }}')
#title=$(playerctl metadata --format '{{ trunc(title, 16) }}')

if [ "$name" = "brave" ] ; then
    arturl="${arturl#file://}"
fi

if [ "$name" = "firefox" ] ; then
    arturl="${arturl#file://}"
fi

if [ "$name" = "mpd" ] ; then
    arturl="$(mpd_cover)"
fi

DEFAULT_IMG=$(grep theme-bg ~/.config/sway/theme | awk '{print $3}' | sed s/~//)

# default
[ -z "$arturl" ] && arturl="$HOME$DEFAULT_IMG"
[ -z "$title" ] && title="N/A"
[ -z "$artist" ] && artist="N/A"
OLD_SONG="$title"

web=false
mpd=false
mpv=false

#if expr "$playerlist" : '.*[brave]' >/dev/null; then
#if expr "$name" : '.*[brave]' >/dev/null; then
if [[ "$name" = "brave" && "$playing" = "Playing" ]] ; then
    web=true
    #echo "we enable web (brave) $web"
else
    web=false
fi

#if expr "$name" : '.*[firefox]' >/dev/null; then
if [[ "$name" = "firefox" && "$playing" = "Playing" ]] ; then
    web=true
    #echo "we enable web $web"
else
    web=false
fi

#if expr "$playerlist" : '.*[mpd]' >/dev/null; then
if expr "$name" : '.*[mpd]' >/dev/null; then
#if [[ "$name" = "mpd" && "$playing" = "Playing" ]] ; then
    if [ "$playing" = "Playing" ] ; then
        mpd=true
        #echo "we enable mpd $mpd"
    else
        mpd=false
    fi
fi

#if expr "$playerlist" : '.*[mpv]' >/dev/null; then
#if expr "$name" : '.*[mpv]' >/dev/null; then
if [[ "$name" = "mpv" && "$playing" = "Playing" ]] ; then
    mpv=true
    #echo "we enable mpv $mpv"
else
    mpv=false
fi

cat <<EOF 
{"playing":"$playing","position":"$position","length":"$length","name":"$name","artist":"$artist","title":"$title","arturl":"$arturl","hpos":"$hpos","hlen":"$hlen","web-active":$web,"mpd-active":$mpd,"mpv-active":$mpv}
EOF
sleep 2
done
