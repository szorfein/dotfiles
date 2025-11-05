#!/usr/bin/env sh

ICON=""

noti() {
    dunstify -u low -i "$ICON" -a "music" "Music" "$1" -r 989
}

while :; do
    ydl.sh "$1"
    [ $? -eq 0 ] && break
    noti "Restarting Tor"
    sudo systemctl restart tor
    sleep 20
done

echo "Download of $1 complete..."
exit 0
