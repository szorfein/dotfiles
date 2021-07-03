#!/usr/bin/env sh

userresources="$HOME"/.Xresources

# merge .Xresources
if [ -f "$userresources" ]; then
  if [ -f /usr/bin/cpp ] ; then
    xrdb -merge -cpp /usr/bin/cpp "$userresources"
  else
    xrdb -merge "$userresources"
  fi
fi

# Launch dbus
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Start wm
session=${1:-awesome}
case $session in
    i3|i3wm ) exec i3;;
    bspwm ) exec bspwm-launch;;
    herbstuf|herbstluftwm ) exec herbstluftwm --locked;;
    spectr|spectrwm ) exec spectrwm 2> /tmp/spectrwm.log;;
    subtle|subtlewm ) exec subtle 2> /tmp/subtle.log;;
    awesome|awesomewm ) exec awesome ;;
    * ) exec $1;;
esac
