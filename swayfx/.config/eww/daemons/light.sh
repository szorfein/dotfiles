#!/usr/bin/env sh

set -o errexit

# check https://smarttech101.com/how-to-send-notifications-in-linux-using-dunstify-notify-send
#
ICON=""

if PID=$(pgrep -f "inotifywait .*brightness"); then
    echo "$PID" | xargs kill
fi

if PIDS=$(pgrep -f "sh .*light.sh") ; then
    MYPID=$$
    PIDS_CLEAN=$(echo "$PIDS" | sed s/"$MYPID"//)
    if [ -n "$PIDS_CLEAN" ] ; then
        echo "clean $PIDS_CLEAN"
        echo "$PIDS_CLEAN" | xargs kill
    fi
fi

#path=/sys/class/backlight/acpi_video0
path=/sys/class/backlight

inotifywait -me modify --format '' "$path"/?*/actual_brightness | while read ; do
LIGHT=$(light -G)
eww update brightness="$LIGHT"
dunstify -i "$ICON" Brightness "$LIGHT" -u low -r 111
done
