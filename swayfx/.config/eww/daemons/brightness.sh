#!/usr/bin/env sh

set -o errexit

ICON=""
DID="666"

if PID=$(pgrep -f "inotifywait .*brightness"); then
    echo "$PID" | xargs kill
fi

#path=/sys/class/backlight/acpi_video0
path=/sys/class/backlight

echo_bright() {
    BRIGHTNESS=$(brightnessctl i | awk -F '[()%]' '/Current brightness:/ {print $2}')
    echo "$BRIGHTNESS"
}

echo_bright

while (inotifywait -e modify "$path"/?*/brightness -qq); do
    echo_bright
    dunstify -i "$ICON" -r "$DID" "Brightness $1" "$BRIGHTNESS% " -h int:value:$((BRIGHTNESS))
done
