#!/usr/bin/env sh

set -o errexit

ISMUTE=false
ICON_ON=""
ICON_OFF=""
ICON="$ICON_OFF"

TOGGLE=false
CHANGE_VOLUME=false

noti() {
    dunstify -u low -i "$ICON_ON" -a "volume" "Volume" "$1" -r 999
}

## PARAMS
if [ -n "$1" ]; then
    if [ "$1" = "toggle" ]; then
        TOGGLE=true
    elif [ "$1" = "set" ]; then
        if [ -n "$2" ]; then
            CHANGE_VOLUME=true
            amixer set Master "$2"%
            noti "$2"
        fi
    fi
fi

AMIXER=$(amixer sget Master | grep "\[")
IS_VOL_ON=$(echo "$AMIXER" | awk '{print $6}' | tr -d "\[[\]")

mute_alsa_card() {
    ISMUTE=true
    ICON="$ICON_OFF"
    amixer sset Master mute > /dev/null
}

unmute_alsa_card() {
    ISMUTE=false
    ICON="$ICON_ON"
    amixer sset Master unmute > /dev/null
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

VOL=$(echo "$AMIXER" | awk '{print $4}' | tr -d "\[%\]")

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
