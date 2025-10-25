#!/usr/bin/env sh

set -o errexit

kill_pid() {
    if PIDS=$($1); then
        echo "$PIDS" | xargs kill "$PIDS"
    fi
}

if PIDS=$(pgrep -f "eww .*"); then
    echo "$PIDS" | xargs kill
fi

kill_pid "pgrep -f sway-workspaces.rb"

#export EWW_SCALE=0.8443388199535182
#export EWW_SCALE=0.84
. ~/.eww_scale

# Without sleep, the 'eww open-many x' keep in the process
# see with (ps aux |  grep eww)
# which produce bug, etc... the only process visible should be 'eww daemon'
#sleep 4
#eww daemon --debug &
#wait
eww daemon &
wait
sleep 1
eww open-many \
    navbar-activator bar \
    sidebar-activator sidebar

# Other daemons
~/.config/eww/scripts/daemons/sway-workspaces.rb > /dev/null 2>&1 &
~/.config/eww/daemons/media.sh > /dev/null 2>&1 &
~/.config/eww/daemons/light.sh > /dev/null 2>&1 &
#~/.config/eww/daemons/volume.sh > /dev/null 2>&1 &
~/.config/eww/daemons/playlists.sh > /dev/null 2>&1 &
~/.config/eww/daemons/iwd.sh > /dev/null 2>&1 &
~/.config/eww/daemons/tor.sh > /dev/null 2>&1 &

# Used to convert default images used by EWW
~/.config/eww/daemons/convert-imgs.sh > /dev/null 2>&1 &
