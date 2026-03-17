#!/usr/bin/env sh

set -o errexit

get_status() {
    if pgrep --quiet -f glances; then
        echo "true"
    else
        echo "false"
    fi
}

just_go() {
    swaymsg -q 'workspace number 6'

    if ! pgrep -a glances; then
        kitty -1 --class monitor -e "glances"
        eww update go_mon="true"
    fi
}

kill_it() {
    if pgrep -a glances; then
        pgrep -f glances | xargs kill
        eww update go_mon="false"
    fi
}

case "$1" in
status) get_status ;;
just_go) just_go ;;
kill_it) kill_it ;;
esac
