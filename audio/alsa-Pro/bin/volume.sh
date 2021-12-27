#!/usr/bin/env sh

set -o errexit

CARD="hw:Pro"

vol_up() {
  amixer -D "$CARD" sset Master 1%+
  vol_get
}

vol_down() {
  amixer -D "$CARD" sset Master 1%-
  vol_get
}

vol_set() {
  amixer -D "$CARD" sset Master "$1"%
  vol_get
}

vol_get() {
  vol=$(amixer -D "$CARD" sget Master | grep -o "[0-9]*%" | head -n 1)
  echo "$vol"
}

case "$1" in
  up)
    vol_up
    shift
    ;;
  down)
    vol_down
    shift
    ;;
  set)
    vol_set "$2"
    shift
    shift
    ;;
  get)
    vol_get
    shift
    ;;
  *)
    echo "call $0 with only [up] or [down]"
    exit 1
esac
