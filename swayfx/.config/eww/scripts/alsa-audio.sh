#!/usr/bin/env sh

set -o errexit

ISMUTE=false
ICON_ON=""
ICON_OFF=""
ICON="$ICON_OFF"
DID="666"

TOGGLE=false
CHANGE_VOLUME=false

noti() {
    dunstify -u low -i "$ICON_ON" -r "$DID" -a "volume" "Volume" "$1"
}

## PARAMS
if [ -n "$1" ]; then
    if [ "$1" = "toggle" ]; then
        TOGGLE=true
    elif [ "$1" = "set" ]; then
        if [ -n "$2" ]; then
            CHANGE_VOLUME=true
            wpctl set-volume @DEFAULT_SINK@ "0.$2"
            noti "0.$2"
        fi
    fi
fi

if wpctl status | grep -i muted; then
    IS_VOL_ON="off"
else
    IS_VOL_ON="on"
fi

mute_alsa_card() {
    ISMUTE=true
    ICON="$ICON_OFF"
    wpctl set-mute @DEFAULT_SINK@ toggle
}

unmute_alsa_card() {
    ISMUTE=false
    ICON="$ICON_ON"
    wpctl set-mute @DEFAULT_SINK@ toggle
}

if [ "$IS_VOL_ON" = "on" ]; then
    ISMUTE=false
    ICON="$ICON_ON"
    $TOGGLE && mute_alsa_card
elif [ "$IS_VOL_ON" = "off" ]; then
    ISMUTE=true
    ICON="$ICON_OFF"
    $TOGGLE && unmute_alsa_card
else
    echo "??"
fi

VOL=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}' | tr -d '0.')

JSON="{"
JSON="$JSON\"volume\":$VOL,"
JSON="$JSON\"muted\":$ISMUTE,"
JSON="$JSON\"muted-icon\":\"$ICON\""
JSON="$JSON}"

if [ $TOGGLE ] || [ $CHANGE_VOLUME ]; then
    eww update audio="$JSON" &
    wait
fi

echo "$JSON"
