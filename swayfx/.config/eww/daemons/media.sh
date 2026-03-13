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

if PIDS=$(pgrep -f "sh .*media.sh"); then
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ]; then
        #echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

if PIDS=$(pgrep -f "playerctl --follow"); then
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ]; then
        #echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

trim_sed() {
    if [ -z "$1" ]; then return 1; fi

    trim=$(echo "$1" | sed -e 's/[[:punct:]]*//g' -e 's/^[[:space:]]*//g' -e 's/[[:space:]]*$//g')
    printf '%s' "$trim"
}

convert_img() {
    IMGNAME="${1##*/}"

    if [ ! -f "/tmp/$IMGNAME" ]; then
        #echo "creating image..."
        touch "/tmp/$IMGNAME"
        # Run in background
        magick "$1" -resize 840x480^ -gravity Center -extent 840x480 "/tmp/$IMGNAME" > /dev/null 2>&1 &
    fi

    printf '%s\n' "/tmp/$IMGNAME"
}

# Honestly, no better solution, enclose each params in form of: @@name@@xXXXx@@name@@
playerctl --follow metadata --format '@@playerName@@{{playerName}}@@playerName@@ @@hpos@@{{position}}@@hpos@@ @@hlen@@{{mpris:length}}@@hlen@@ @@status@@{{lc(status)}}@@status@@ @@position@@{{duration(position)}}@@position@@ @@length@@{{duration(mpris:length)}}@@length@@ @@artUrl@@{{mpris:artUrl}}@@artUrl@@ @@artist@@{{artist}}@@artist@@ @@title@@{{title}}@@title@@ @@url@@{{url}}@@url@@' | while read -r line; do

    player_name="$(sed 's/.*@@playerName@@\(.*\)@@playerName@@.*/\1/' <<< "$line")"
    #volume="$(sed 's/.*@@volume@@\(.*\)@@volume@@.*/\1/' <<< "$line")"
    status="$(sed 's/.*@@status@@\(.*\)@@status@@.*/\1/' <<< "$line")"
    #url="$(sed 's/.*@@url@@\(.*\)@@url@@.*/\1/' <<< "$line")"
    position="$(sed 's/.*@@position@@\(.*\)@@position@@.*/\1/' <<< "$line")"
    length="$(sed 's/.*@@length@@\(.*\)@@length@@.*/\1/' <<< "$line")"
    hpos="$(sed 's/.*@@hpos@@\(.*\)@@hpos@@.*/\1/' <<< "$line")"
    hlen="$(sed 's/.*@@hlen@@\(.*\)@@hlen@@.*/\1/' <<< "$line")"
    arturl="$(sed 's/.*@@artUrl@@\(.*\)@@artUrl@@.*/\1/' <<< "$line")"

    artist="$(sed 's/.*@@artist@@\(.*\)@@artist@@.*/\1/' <<< "$line")"
    title="$(sed 's/.*@@title@@\(.*\)@@title@@.*/\1/' <<< "$line")"

    if [ "$player_name" = "brave" ]; then
        arturl="${arturl#file://}"
    fi

    if [ "$player_name" = "firefox" ]; then
        arturl="${arturl#file://}"
    fi

    if [ "$player_name" = "kew" ]; then
        #arturl="$(mpd_cover)"
        if find=$(find "$HOME/musics" -type f -regex ".*\.\(jpg\|png\|jpeg\)" -print | fzf -f "$title" | head -1); then
            arturl="$find"
        fi
    fi

    if [ "$player_name" = "mpv" ]; then
        music_path=$(ps x | grep mpris.so | grep -o '[^ ]\+$' | head -1)
        # sometime inaccurate...
        if find=$(find "$music_path" -type f -regex ".*\.\(jpg\|png\|jpeg\)" -print | fzf -f "$title" | head -1); then
            arturl="$find"
        fi
    fi

    DEFAULT_IMG=$(grep theme-bg ~/.config/sway/theme | awk '{print $3}' | sed s:~/images/::)

    # default
    if [ -z "$arturl" ]; then
        arturl="/tmp/$DEFAULT_IMG"
    elif [ ! -f "$arturl" ]; then
        arturl="/tmp/$DEFAULT_IMG"
    fi

    [ -z "$title" ] && title="N/A"
    [ -z "$artist" ] && artist="N/A"

    web=false
    kew=false
    mpv=false

    # The image size has a HUGE impact on eww performance !
    # use imagemagick to convert the image
    arturl=$(convert_img "$arturl")

    if expr "$player_name" : '.*[brave]' > /dev/null; then
        if [ "$status" = "playing" ]; then
            web=true
        fi
    fi

    if [ "$player_name" = "firefox" ] && [ "$status" = "playing" ]; then
        web=true
    fi

    if [ "$player_name" = "kew" ] && [ "$status" = "playing" ]; then
        kew=true
    fi

    if [ "$player_name" = "mpv" ] && [ "$status" = "playing" ]; then
        mpv=true
    fi

    #    cat << EOF
    JSON="{\"playing\":\"$status\",\"position\":\"$hpos\",\"length\":\"$hlen\",\"name\":\"$player_name\",\"artist\":\"${artist:0:20}\",\"title\":\"${title:0:18}\",\"arturl\":\"$arturl\",\"hpos\":\"$position\",\"hlen\":\"$length\",\"web-active\":$web,\"kew-active\":$kew,\"mpv-active\":$mpv}"
    #EOF
    #echo "$name"
    #echo "$JSON"
    eww update media="$JSON"
done
