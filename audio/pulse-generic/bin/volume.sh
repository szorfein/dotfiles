#!/usr/bin/env sh

set -o errexit -o nounset

sink="@DEFAULT_SINK@"

vol_up() {
  pactl set-sink-mute "$sink" false
  pactl set-sink-volume "$sink" +1%
  vol_get
}

vol_down() {
  pactl set-sink-mute "$sink" false
  pactl set-sink-volume "$sink" -1%
  vol_get
}

vol_set() {
  pactl set-sink-mute "$sink" false
  pactl set-sink-volume "$sink" "$1"%
  vol_get
}

vol_get() {
  vol=$(pacmd list-sinks | grep -o "[0-9]*% " | head -1)
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
    echo "call $0 with only [up] | [down] | [set] NUMBER"
    exit 1
esac
