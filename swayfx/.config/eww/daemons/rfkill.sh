#!/usr/bin/env sh

set -o errexit

ICON_OFF="airplanemode_inactive"
ICON_ON="plane_contrails"
ICON="$ICON_OFF"

RFKILL_OUTPUT=$(rfkill -n | head -n1)
STATUS=$(echo "$RFKILL_OUTPUT" | awk '{print $4}')
CARD=$(echo "$RFKILL_OUTPUT" | awk '{print $2}')

if [ "$STATUS" = "blocked" ]; then
    ICON="$ICON_ON"
fi

noti() {
    dunstify -a airplane -u low -i "$ICON_ON" airplane "$1" -r 666
}

die() {
    noti "$1"
    exit 1
}

display() {
    cat << EOF
{"status":"$STATUS","icon":"$ICON","card": "$CARD"}
EOF
}

update_eww() {
    _rfkill_output=$(rfkill -n | head -n1)
    _status=$(echo "$_rfkill_output" | awk '{print $4}')
    _card=$(echo "$_rfkill_output" | awk '{print $2}')
    _icon="$ICON_OFF"
    if [ "$_status" = "blocked" ]; then _icon="$ICON_ON"; fi
    eww update rfkill="{\"status\":\"$_status\",\"icon\":\"$_icon\",\"card\":\"$_card\"}"
}

do_toggle() {
    if [ "$STATUS" = "unblocked" ]; then
        rfkill block all
        noti "unblocked to block"
        update_eww
    elif [ "$STATUS" = "blocked" ]; then
        rfkill unblock wifi
        noti "blocked to unblock"
        update_eww
    fi
}

[ -z "$1" ] && die "No args"

case "$1" in
status) display ;;
toggle) do_toggle ;;
esac
