#!/usr/bin/env sh

set -o errexit

if [ -f /tmp/daemon-playlists ] ; then
    OLDPID=$(cat </tmp/daemon-playlists)
    kill "$OLDPID"
    echo "killing $OLDPID"
fi

echo "$$">/tmp/daemon-playlists

while :; do
    ~/.config/eww/scripts/mpc.sh update
    sleep 99
done
