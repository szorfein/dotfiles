#!/usr/bin/env sh

set -o errexit

if PIDS=$(pgrep -f "sh .*playlists.sh"); then
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ]; then
        echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

#while :; do;
#~/.config/eww/scripts/mpc.sh update
#sleep 99
#done
