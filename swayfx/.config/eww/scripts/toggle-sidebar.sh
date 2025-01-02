#!/usr/bin/env sh

set -o errexit

pid_file=/tmp/sidebar

[ -f "$pid_file" ] && exit 0

pid=$(echo $$)
echo "$pid" >>"$pid_file"

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

if [ "$1" = "show" ] ; then
    if [ "$get_visible" = "false" ] ; then
        show_menu
    fi
fi

rm -r "$pid_file"
