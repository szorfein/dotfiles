#!/usr/bin/env sh

set -o errexit

AUDIO="pulseaudio"

if pidof pipewire > /dev/null 2>&1; then
    AUDIO="pipewire"
elif ! pidof pulseaudio > /dev/null 2>&1; then
    AUDIO="alsa"
fi

if PIDS=$(pgrep -f "sh .*volume.sh"); then
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ]; then
        echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

pipewire_daemon() {
    echo "pipewire"
    vol=$(~/.config/eww/scripts/volume.sh get)
    eww update volume="$vol"
}

pulseaudio_daemon() {
    echo "pulse"
    pactl subscribe 2> /dev/null | grep --line-buffered "sink #" | while read -r _; do
        vol=$(~/.config/eww/scripts/volume.sh get)
        eww update volume="$vol"
    done
}

alsa_daemon() {
    echo "alsa"
    vol=$(~/.config/eww/scripts/volume.sh get)
    echo "$vol"
    eww update volume="$vol"
}

case "$AUDIO" in
*pipewire*) pipewire_daemon ;;
*pulseaudio*) pulseaudio_daemon ;;
*alsa*) alsa_daemon ;;
esac
