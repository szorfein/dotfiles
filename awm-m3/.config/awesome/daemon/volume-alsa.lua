local spawn = require('awful.spawn')
local timer = require('gears.timer')

local string = { match = string.match }

local function volume_status()
  spawn.easy_async('amixer -M get Master', function(stdout)
    local volume = string.match(stdout, "%[([%d]+)%%%]")
    local state = string.match(stdout, "%[([%l]*)%]")
    local mute = false

    if volume == "0" then
      awesome.emit_signal('daemon::volume', 0, true)
    end

    if state == "" and volume == "0"    -- handle mixers without mute
      or state == "off" then
      mute = true
    end

    awesome.emit_signal('daemon::volume', volume, mute)
  end)
end

timer {
  timeout = 6,
  autostart = true,
  call_now = true,
  callback = function()
    volume_status()
  end
}
