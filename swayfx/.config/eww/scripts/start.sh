#!/usr/bin/env sh

set -o errexit

kill_pid() {
  if PIDS=$($1) ; then
    kill $PIDS
  fi
}

kill_pid "pgrep -x eww"
kill_pid "pgrep -f sway-workspaces.rb"

#export EWW_SCALE=0.8443388199535182
#export EWW_SCALE=0.84
. ~/.eww_scale

# Without sleep, the 'eww open-many x' keep in the process
# see with (ps aux |  grep eww)
# which produce bug, etc... the only process visible should be 'eww daemon'
sleep 5
eww daemon &
wait
eww open-many \
    navbar-activator bar \
    sidebar-activator sidebar

# Other daemons
~/.config/eww/scripts/daemons/sway-workspaces.rb >/dev/null 2>&1 &
~/.config/eww/daemons/media.sh >/dev/null 2>&1 &
~/.config/eww/daemons/light.sh >/dev/null 2>&1 &
~/.config/eww/daemons/volume.sh >/dev/null 2>&1 &
~/.config/eww/daemons/playlists.sh >/dev/null 2>&1 &
~/.config/eww/daemons/iwd.sh >/dev/null 2>&1 &
~/.config/eww/daemons/tor.sh >/dev/null 2>&1 &
