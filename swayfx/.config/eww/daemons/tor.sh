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

test_systemd() {
    #echo "test systemd"
    if systemctl is-active tor > /dev/null; then
        DAEMON=true
    fi
}

reload_tor() {
    is_systemd && {
        noti "reloading with systemd..."
        if sudo systemctl restart tor; then noti "is reloaded"; else noti "fail to reload"; fi
    }
}

start_tor() {
    is_systemd && {
        noti "starting with systemd..."
        if sudo systemctl start tor; then noti "has started"; else noti "fail to start"; fi
    }
}

stop_tor() {
    is_systemd && {
        noti "stopping with systemd..."
        if sudo systemctl stop tor; then noti "is stopped"; else noti "fail to stop"; fi
    }
}

get_status() {
    is_systemd && test_systemd
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

[ -z "$1" ] && die "no arg"

case "$1" in
status) get_status ;;
toggle) do_toggle ;;
stop) do_stop ;;
esac
