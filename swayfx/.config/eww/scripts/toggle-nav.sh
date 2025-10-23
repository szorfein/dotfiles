#!/usr/bin/env sh

set -o errexit

hide_menu() {
    eww close bar &
    wait
    eww update navbar-visible=false
}

show_menu() {
    eww open bar &
    wait
    eww update navbar-visible=true
}

test_bar() {
    if eww active-windows | grep -q -x "^bar: bar$"; then
        return 0
    else
        return 1
    fi
}

if [ "$1" = "toggle" ]; then
    if test_bar; then
        hide_menu
    else
        show_menu
    fi
fi

if [ "$1" = "show" ]; then
    if ! test_bar; then
        show_menu
    fi
fi

if [ "$1" = "hide" ]; then
    if test_bar; then
        hide_menu
    fi
fi
