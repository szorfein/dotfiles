#!/usr/bin/env sh

pgrep -x eww | xargs kill -9
pgrep -f sway-workspaces.rb | xargs kill -9

# Without sleep, the 'eww open-many x' keep in the process
# see with (ps aux |  grep eww)
# which produce bug, etc... the only process visible should be 'eww daemon'
eww daemon \
  && sleep 2 \
  && eww open-many bar

~/.config/eww/scripts/daemons/sway-workspaces.rb
