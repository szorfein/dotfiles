#!/usr/bin/env sh

while :; do
    ydl.sh "$1"
    [ $? -eq 0 ] && break
    echo "Restarting Tor"
    sudo systemctl restart tor
    sleep 20
done

echo "Download of $1 complete..."
exit 0
