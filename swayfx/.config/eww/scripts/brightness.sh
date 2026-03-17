#!/usr/bin/env bash

set -o errexit

MIN="2"
MAX="100"

if [ -n "$1" ] && [[ "$1" =~ ^[0-9]+$ ]]; then
    if [ "$1" -lt "$MIN" ] || [ "$1" -eq "$MIN" ]; then
        brightnessctl set "$MIN"% -q
    elif [ "$1" -gt "$MAX" ] || [ "$1" -eq "$MAX" ]; then
        brightnessctl set "$MAX"% -q
    else
        brightnessctl set "$1"% -q
    fi
fi
