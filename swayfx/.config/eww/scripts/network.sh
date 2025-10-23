#!/usr/bin/env sh

set -o errexit

# TODO: check for a daemon with: ip monitor
# https://github.com/waltinator/net-o-matic/blob/master/net-o-matic
ICON_WIFI_ON=""
ICON_WIFI_KILLED=""

wifi_killed="$(eww get wifi-killed)"

wifi_kill() {
    rfkill block all
    eww update wifi-killed=true wifi-killed-icon="$ICON_WIFI_KILLED"
}

wifi_raise() {
    rfkill unblock wifi
    eww update wifi-killed=false wifi-killed-icon="$ICON_WIFI_ON"
}

if [ "$1" = "wifi-toggle" ]; then
    if [ "$wifi_killed" = "true" ]; then
        wifi_raise
    else
        wifi_kill
    fi
fi
