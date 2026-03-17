#!/usr/bin/env sh

set -o errexit

get_status() {
    if pgrep --quiet -f "bulletty"; then
        echo "true"
    else
        echo "false"
    fi
}

just_go() {
    swaymsg -q 'workspace number 7'

    if ! pgrep -a "bulletty"; then
        kitty -1 --class news -e "bulletty"
        eww update go_news="true"
    fi
}

kill_it() {
    if pgrep -f bulletty --quiet; then
        pgrep -f bulletty | xargs kill
        eww update go_news="false"
    fi
}

case "$1" in
status) get_status ;;
just_go) just_go ;;
kill_it) kill_it ;;
esac
