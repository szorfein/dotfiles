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
    kill "$OLDPID"
    echo "killing $OLDPID"
fi

pipewire_daemon() {
    :
}

pulseaudio_daemon() {
    :
}

alsa_daemon() {
    while :; do
        vol=$(~/.config/eww/scripts/volume.sh get)
        eww update volume="$vol"
        sleep 30
    done
}

echo "my pid is $$"
echo "$$">/tmp/daemon-volume

case "$AUDIO" in
    *pipewire*) pipewire_daemon ;;
    *pulseaudio*) pulseaudio_daemon ;;
    *alsa*) alsa_daemon ;;
esac
