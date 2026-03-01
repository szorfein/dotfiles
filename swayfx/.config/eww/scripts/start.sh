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
pidof -q eww || { eww daemon & }

# Other daemons
~/.config/eww/scripts/daemons/sway-workspaces.rb > /dev/null 2>&1 &
~/.config/eww/daemons/media.sh > /dev/null 2>&1 &
~/.config/eww/daemons/light.sh > /dev/null 2>&1 &
#~/.config/eww/daemons/volume.sh > /dev/null 2>&1 &
#~/.config/eww/daemons/playlists.sh > /dev/null 2>&1 &
~/.config/eww/daemons/iwd.sh > /dev/null 2>&1 &
~/.config/eww/daemons/tor.sh > /dev/null 2>&1 &

# Used to convert default images used by EWW
~/.config/eww/daemons/convert-imgs.sh > /dev/null 2>&1 &

# Pre-generated list
~/.config/eww/daemons/generate-list.sh > /dev/null 2>&1 &

# Open bar for multiscreen or not
sleep 3

poutputs=$(wlr-randr --json | jq -r '.[] | select(.enabled == true) | .name')

screen=0
for mon in $poutputs; do
    echo "$mon"
    # config with open-many is weird... https://elkowar.github.io/eww/configuration.html#window-arguments
    eww open-many \
        navbar-activator:na-"$mon" --arg na-"$mon":monitor="$mon" --arg na-"$mon":screen="$screen" \
        sidebar-activator:sa-"$mon" --arg sa-"$mon":monitor="$mon" --arg sa-"$mon":screen="$screen" \
        sidebar:sb-"$mon" --arg sb-"$mon":monitor="$mon" --arg sb-"$mon":screen="$screen" \
        bar:rb-"$mon" --arg rb-"$mon":monitor="$mon" --arg rb-"$mon":screen="$screen"

    screen=$((screen + 1))
done
