#!/usr/bin/env sh

ICON=""

noti() {
    dunstify -u low -i "$ICON" -a "music" "Music" "$1" -r 989
}

restart_tor() {
    if command -v systemctl; then
        sudo systemctl restart tor &
        wait
    elif command -v sv; then
        sudo sv restart tor &
        wait
    fi
}

while :; do
    if ydl.sh "$1"; then break; fi
    #[ $? -eq 0 ] && break
    noti "Restarting Tor"
    restart_tor
    #sleep 20
    sleep 4
done

echo "Download of $1 complete..."
exit 0
