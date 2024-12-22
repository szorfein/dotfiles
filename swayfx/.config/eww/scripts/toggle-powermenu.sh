#!/usr/bin/env sh

set -o errexit

get_visible=$(eww get powermenu-visible)

hide_menu() {
  eww close powermenu
  eww update powermenu-visible=false
}

show_menu() {
  eww open powermenu
  eww update powermenu-visible=true
}

if [ "$get_visible" = "true" ] ; then
  hide_menu
else
  show_menu
fi
