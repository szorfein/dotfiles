#!/usr/bin/env sh

set -o errexit

# check https://smarttech101.com/how-to-send-notifications-in-linux-using-dunstify-notify-send
#
ICON=$(echo -e "\ue3a7")
LIGHT="1"

if PID=$(pgrep -f "inotifywait .*brightness"); then
    echo "$PID" | xargs kill
fi

if PIDS=$(pgrep -f "sh .*light.sh"); then
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ]; then
        echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

#path=/sys/class/backlight/acpi_video0
path=/sys/class/backlight

update() {
    LIGHT=$(light -G)
    eww update brightness="$LIGHT" &
    wait
}

update

while (inotifywait -e modify "$path"/?*/brightness -qq); do
    update
    dunstify -i "$ICON" Brightness "$LIGHT" -u low -r 111
done
