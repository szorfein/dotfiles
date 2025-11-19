#!/bin/sh

# Change volume for ALSA directly with amixer

# Card listed to: cat /proc/asound/cards
CARD="hw:Pro"

vol() {
  amixer -D $CARD sset Master $1 >/dev/null 2>&1
  exit 0
}

while [ "$#" -gt 0 ] ; do
  case "$1" in
    -i | --inc)
      vol "$2%+"
      shift
      shift
      ;;
    -d | --dec)
      vol "$2%-"
      shift
      shift
      ;;
  esac
done
