#!/usr/bin/env sh

set -o errexit

kill_pid() {
  if PID=$($1) ; then
    kill -9 $PID
  fi
}

kill_pid "pgrep -x eww"
kill_pid "pgrep -f sway-workspaces.rb"

# Without sleep, the 'eww open-many x' keep in the process
# see with (ps aux |  grep eww)
# which produce bug, etc... the only process visible should be 'eww daemon'
eww daemon \
  && sleep 2 \
  && eww open-many \
         navbar-activator bar \
         sidebar-activator sidebar

~/.config/eww/scripts/daemons/sway-workspaces.rb
