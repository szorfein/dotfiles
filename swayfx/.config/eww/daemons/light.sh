#!/usr/bin/env sh

set -o errexit

# check https://smarttech101.com/how-to-send-notifications-in-linux-using-dunstify-notify-send
#
ICON=""

if PID=$(pgrep -x inotifywait); then
    killall "$PID"
fi

#path=/sys/class/backlight/acpi_video0
path=/sys/class/backlight

inotifywait -me modify --format '' "$path"/?*/actual_brightness | while read ; do
LIGHT=$(light -G)
eww update brightness="$LIGHT"
dunstify -i "$ICON" Brightness "$LIGHT" -u low -r 111
done
