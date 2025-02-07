#!/usr/bin/env sh

set -o errexit

if PID=$(pgrep -x inotifywait) ; then
    kill $PID
fi

#path=/sys/class/backlight/acpi_video0
path=/sys/class/backlight

inotifywait -me modify --format '' "$path"/?*/actual_brightness | while read ; do
eww update brightness=$(light -G)
done
