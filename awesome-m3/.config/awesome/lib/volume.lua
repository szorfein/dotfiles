local spawn = require('awful.spawn')
local volume = class()

function volume:up()
  if is_pulse then
    spawn.with_shell('pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +1%')
  else
    spawn('amixer sset Master 1%+')
  end
end

function volume:down()
  if is_pulse then
    spawn.with_shell('pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -1%')
  else
    spawn('amixer sset Master 1%-')
  end
end

function volume:set(value)
  spawn.with_shell('~/.config/awesome/scripts/volume.sh ' .. value)
end

return volume
