#!/usr/bin/env sh

set -o errexit

get_status() {
    if pgrep --quiet -f "kew"; then
        echo "true"
    else
        echo "false"
    fi
}

just_go() {
    swaymsg -q 'workspace number 8'

    if ! pgrep -a "kew"; then
        kitty -1 --class musics -e "kew"
        eww update go_musics="true"
    fi
}

kill_it() {
    if pgrep -f "kew"; then
        pgrep -f "kew" | xargs kill
        eww update go_musics="false"
    fi
}

case "$1" in
status) get_status ;;
just_go) just_go ;;
kill_it) kill_it ;;
esac
