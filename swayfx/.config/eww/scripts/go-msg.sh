#!/usr/bin/env sh

set -o errexit

get_status() {
    if pgrep --quiet -f element; then
        echo "true"
    else
        echo "false"
    fi
}

just_go() {
    swaymsg -q 'workspace number 5'

    if ! pgrep --quiet -f "element"; then
        element-desktop &
        eww update go_msg="true"
    fi
}

kill_it() {
    if pgrep --quiet -f element; then
        pgrep -f element | xargs kill
        eww update go_msg="false"
    fi
}

case "$1" in
status) get_status ;;
just_go) just_go ;;
kill_it) kill_it ;;
esac
