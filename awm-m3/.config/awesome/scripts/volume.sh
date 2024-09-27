#!/usr/bin/env sh

set -o errexit

is_pulse() {
  if [ -f '/bin/pacmd' ] || [ -f '/usr/bin/pacmd' ]; then
    return 0
  else
    return 1
  fi
}

set_vol() {
  if is_pulse; then
    echo "ex pulse"
    pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "$1"
  else
    echo "Setting volume to $1 using ALSA"
    amixer -q sset Master "$1"
  fi
}

set_vol "$1%"
