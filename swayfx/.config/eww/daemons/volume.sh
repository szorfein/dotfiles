#!/usr/bin/env sh

set -o errexit

AUDIO="pulseaudio"

if pidof pipewire >/dev/null 2>&1; then
    AUDIO="pipewire"
elif ! pidof pulseaudio >/dev/null 2>&1; then
    AUDIO="alsa"
fi

if [ -f /tmp/daemon-volume ] ; then
    OLDPID=$(cat </tmp/daemon-volume)
    if [ -n "$OLDPID" ] && $(pgrep -ns "$OLDPID") ; then
        kill -9 "$OLDPID"
    fi
    echo "killing $OLDPID"
fi

if PIDS=$(pgrep -f "sh .*volume.sh") ; then
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ] ; then
        echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

pipewire_daemon() {
    echo "pipewire"
    while :; do
        vol=$(~/.config/eww/scripts/volume.sh get)
        eww update volume="$vol"
        exec sleep 30
    done
}

pulseaudio_daemon() {
    echo "pulse"
    pactl subscribe 2> /dev/null | grep --line-buffered "sink #" | while read -r _ ; do
        vol=$(~/.config/eww/scripts/volume.sh get)
        eww update volume="$vol"
    done
}

alsa_daemon() {
    echo "alsa"
    while :; do
        vol=$(~/.config/eww/scripts/volume.sh get)
        echo "$vol"
        eww update volume="$vol"
        exec sleep 30
    done
}

echo "my pid is $MYPID"
echo "$MYPID">/tmp/daemon-volume

case "$AUDIO" in
    *pipewire*) pipewire_daemon ;;
    *pulseaudio*) pulseaudio_daemon ;;
    *alsa*) alsa_daemon ;;
esac
