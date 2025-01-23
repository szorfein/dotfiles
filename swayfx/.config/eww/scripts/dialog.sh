#!/usr/bin/env sh

set -o errexit

open() {
    eww update "$1"-visible=true
    eww open "$1"
}

close() {
    eww update "$1"-visible=false
    eww close "$1"
}

toggle() {
    curr=$(eww get "$1"-visible)
    if [ "$curr" = "true" ] ; then
        close "$1"
    else
        open "$1"
    fi
}

if [ "$1" = "open" ] ; then
    open "$2"
fi

if [ "$1" = "close" ] ; then
    close "$2"
fi

if [ "$1" = "toggle" ] ; then
    toggle "$2"
fi
