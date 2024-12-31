#!/usr/bin/env sh

set -o errexit

pid_file=/tmp/navbar

[ -f "$pid_file" ] && exit 0

pid=$(echo $$)
echo $pid >>$pid_file

get_visible=$(eww get navbar-visible)

hide_menu() {
  eww close bar
  eww update navbar-visible=false
}

show_menu() {
  eww open bar
  eww update navbar-visible=true
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
