#!/usr/bin/env sh

set -o errexit

get_visible=$(eww get sidebar-visible)

hide_menu() {
  eww close sidebar
  eww update sidebar-visible=false
}

show_menu() {
  eww open sidebar
  eww update sidebar-visible=true
}

if [ "$1" = "toggle" ] ; then
    if [ "$get_visible" = "true" ] ; then
        hide_menu
    else
        show_menu
    fi
fi

if [ "$1" == "show" ] ; then
    if [ "$get_visible" = "false" ] ; then
        show_menu
    fi
fi
