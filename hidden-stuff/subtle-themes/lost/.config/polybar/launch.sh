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
  polybar bottom-launcher &
elif [ $1 = i3 ] ; then
  polybar i3top &
  polybar i3bottom &
else
  echo "WTF ???"
fi

echo "Bars launched..."
