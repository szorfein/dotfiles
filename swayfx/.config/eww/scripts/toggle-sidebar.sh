#!/usr/bin/env sh

set -o errexit

hide_menu() {
    eww close sidebar &
    wait
    eww update sidebar-visible=false
}

show_menu() {
    eww open sidebar &
    wait
    eww update sidebar-visible=true
}

test_sidebar() {
    if eww active-windows | grep -q -x "^sidebar: sidebar$"; then
        return 0
    else
        return 1
    fi
}

if [ "$1" = "toggle" ]; then
    if test_sidebar; then
        hide_menu
    else
        show_menu
    fi
fi

if [ "$1" = "show" ]; then
    if ! test_sidebar; then
        show_menu
    fi
fi

if [ "$1" = "hide" ]; then
    if test_sidebar; then
        hide_menu
    fi
fi
