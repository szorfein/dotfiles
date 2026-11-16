#!/usr/bin/env sh

set -o errexit

STATUS=false
DAEMON=false
ICON_OFF="invert_colors_off"
ICON_ON="invert_colors"
ICON="$ICON_OFF"

noti() {
    dunstify -a tor -u low -i "$ICON_ON" tor "$1" -r 666
}

die() {
    noti "$1"
    exit 1
}

is_systemd() {
    if readlink /sbin/init | grep -q systemd; then
        return 0
    else
        return 1
    fi
}

# sv on Voidlinux
has_sv() {
    if [ -f /bin/sv ] || [ -f /sbin/sv ]; then
        return 0
    else
        return 1
    fi
}

test_tor() {
    if ! $DAEMON; then
        return 0
    fi

    if curl -s https://check.torproject.org/api/ip | grep -q true; then
        STATUS=true
        ICON="$ICON_ON"
    fi
}

display() {
    cat << EOF
{"status":"$STATUS","icon":"$ICON"}
EOF
}

test_daemon() {
    #echo "test systemd"
    if pidof tor > /dev/null; then
        DAEMON=true
    fi
}

# TODO: Should write for 'sudo' or 'doas'
reload_tor() {
    if is_systemd; then
        noti "reloading with systemd..."
        if sudo systemctl restart tor; then noti "is reloaded"; else noti "fail to reload"; fi
    elif has_sv; then
        noti "reloading with sv..."
        if sudo sv restart tor; then
            noti "is reloaded"
        else
            noti "fail to reload"
        fi
    else
        noti "Can't restart tor, no systemd or sv found..."
    fi
}

get_status() {
    test_daemon
}

start_tor() {
    if is_systemd; then
        noti "starting with systemd..."
        if sudo systemctl start tor; then noti "has started"; else noti "fail to start"; fi
    elif has_sv; then
        noti "starting with sv..."
        if sudo sv start tor; then noti "has started"; else noti "fail to start"; fi
    else
        noti "Cannot stop tor, no systemd or sv found..."
    fi
}

stop_tor() {
    if is_systemd; then
        noti "Stopping with systemd..."
        if sudo systemctl stop tor; then noti "is stopped"; else noti "fail to stop"; fi
    elif has_sv; then
        noti "Stopping with sv..."
        if sudo sv stop tor; then noti "is stopped"; else noti "fail to stop"; fi
    else
        noti "Cannot stop tor (no systemd or sv)..."
    fi
}

get_status() {
    test_daemon
    test_tor
    display
}

do_toggle() {
    tor=$(eww get tor)
    _status=$(echo "$tor" | jq .status)
    if [ "$_status" = \""true\"" ]; then
        reload_tor
    elif [ "$_status" = \""false\"" ]; then
        start_tor
    fi
}

do_stop() {
    tor=$(eww get tor)
    _status=$(echo "$tor" | jq .status)
    if [ "$_status" = \""true\"" ]; then
        stop_tor
    fi
}

[ -z "$1" ] && exit

case "$1" in
status) get_status ;;
toggle) do_toggle ;;
stop) do_stop ;;
esac
