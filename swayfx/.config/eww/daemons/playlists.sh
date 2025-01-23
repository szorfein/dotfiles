#!/usr/bin/env sh

set -o errexit

if [ -f /tmp/daemon-playlists ] ; then
    OLDPID=$(cat </tmp/daemon-playlists)
    if kill "$OLDPID" 2>/dev/null ; then
        echo "killing $OLDPID"
    fi
fi

echo "$$">/tmp/daemon-playlists

while :; do
    ~/.config/eww/scripts/mpc.sh update
    sleep 99
done
