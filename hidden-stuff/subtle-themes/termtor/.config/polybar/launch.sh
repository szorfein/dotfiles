#!/usr/bin/env sh

killall -q polybar

polybar_proc=$(pgrep -u $UID -x polybar)

# Terminate already running bar instances
for i in ${polybar_proc} ; do
    kill -9 $i
done

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [ $1 = subtle ] ; then
  polybar top &
else
  echo "WTF ???"
fi

echo "Bars launched..."
