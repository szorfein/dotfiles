#!/usr/bin/env bash

set -o errexit 

SCAN_RES=""

# https://gist.github.com/foxyfocus/4388f34059af56e179fb4aa00ca0a913

if PIDS=$(pgrep -f "sh .*tor.sh") ; then 
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ] ; then
        echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi


test_tor() {
    if curl -s https://check.torproject.org/api/ip | grep -q true ; then
        eww update tor-enabled=true
    else
        eww update tor-enabled=false
    fi
}

while :; do
    test_tor
    sleep 60
done
