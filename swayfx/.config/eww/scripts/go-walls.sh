#!/usr/bin/env sh

set -o errexit

get_status() {
    if pgrep --quiet -f "yazi $HOME/images"; then
        echo "true"
    else
        echo "false"
    fi
}

just_go() {
    swaymsg -q 'workspace number 9'

    if ! pgrep -f "yazi $HOME/images"; then
        kitty -1 --class wallpapers -e yazi ~/images
        eww update go_wall="true"
    fi
}

kill_it() {
    if pgrep -f "yazi $HOME/images"; then
        pgrep -f "yazi $HOME/images" | xargs kill
        eww update go_wall="false"
    fi
}

case "$1" in
status) get_status ;;
just_go) just_go ;;
kill_it) kill_it ;;
esac
