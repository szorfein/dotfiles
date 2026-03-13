#!/usr/bin/env sh

set -o errexit

get_status() {
    if pgrep --quiet -f librewolf; then
        echo "true"
    else
        echo "false"
    fi
}

just_go() {
    swaymsg -q 'workspace number 2'

    if ! pgrep -a librewolf; then
        librewolf
        eww update go_web="true"
    fi
}

kill_it() {
    if pgrep -a librewolf; then
        pgrep -f librewolf | xargs kill
        eww update go_web="false"
    fi
}

case "$1" in
status) get_status ;;
just_go) just_go ;;
kill_it) kill_it ;;
esac
