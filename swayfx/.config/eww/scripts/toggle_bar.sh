#!/usr/bin/env sh

set -o errexit

curr=$(eww get bar_visible)
echo "curr is $curr"

if [ "$curr" = "true" ] ; then
  echo "is true - remove bar"
  eww close bar
  eww update bar_visible=false
else
  echo "is false - open bar"
  eww open bar
  eww update bar_visible=true
fi

