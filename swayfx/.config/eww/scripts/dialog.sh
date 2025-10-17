#!/usr/bin/env sh

set -o errexit

open() {
    eww open "$1" &
    wait
    eww update "$1"-visible=true
}

close() {
    eww close "$1" &
    wait
    eww update "$1"-visible=false
}

test_dialog() {
    #echo "testing $1"
    if eww active-windows | grep -q -x "^$1: $1$"; then
        return 0
    else
        return 1
    fi
}

if [ "$1" = "open" ]; then
    if ! test_dialog "$2"; then
        open "$2"
    fi
fi

if [ "$1" = "close" ]; then
    if test_dialog "$2"; then
        close "$2"
    fi
fi

if [ "$1" = "toggle" ]; then
    if test_dialog "$2"; then
        close "$2"
    else
        open "$2"
    fi
fi
