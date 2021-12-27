-- Create a signal: daemon::volume
-- return values: volume [number], is_muted [0 or 1]
local spawn = require("awful.spawn")
local noti = require("utils.noti")

local volume_old = -1
local msg_old = ""
local start = true

local function emit_volume_info_alsa()
  spawn.easy_async_with_shell("~/bin/volume.sh get", function(stdout)
    local volume = stdout:match('(%d+)%%')

    if not volume then
      local msg = "No volume found"
      if msg ~= msg_old then
        noti.warn(msg)
      end
      msg_old = msg
      return
    end

    if volume ~= volume_old then
      local is_muted = volume == 0 and 1 or 0
      if not start then
        local icon = "<span foreground='" .. M.x.primary .. "'> 墳 </span>"
        noti.info(icon .. volume .."%")
      end
      awesome.emit_signal("daemon::volume", tonumber(volume), is_muted)
    end
    volume_old = volume
    start = false
  end)
end

local function emit_volume_info_pulse()
  spawn.easy_async("pacmd list-sinks", function(stdout)
    local volume = stdout:match('(%d+)%% /')
    local is_muted = stdout:match('Mute:(%s+)[yes]') and 1 or 0

    if not volume then
      local msg = "No volume found"
      if msg ~= msg_old then
        noti.warn(msg)
      end
      msg_old = msg
      return
    end

    if volume ~= volume_old then
      if not start then
        local icon = "<span foreground='" .. M.x.primary .. "'> 墳 </span>"
        noti.info(icon .. volume .."%")
      end
      awesome.emit_signal("daemon::volume", tonumber(volume), is_muted)
    end
    volume_old = volume
    start = false
  end)
end

if sound_system == "alsa" then
  local gtimer = require("gears.timer")

  gtimer.start_new(5, function()
    emit_volume_info_alsa()
    return true
  end)
else -- asume you use pulseaudio
  -- initialize signal
  emit_volume_info_pulse()

  local volume_script = [[
    sh -c '
    pactl subscribe 2>/dev/null | grep --line-buffered "sink"
    '
  ]]

  -- update the signal when receive new things
  spawn.easy_async_with_shell("pgrep -x pactl | xargs kill", function()

    -- Run emit_volume_info() with each line printed
    spawn.with_line_callback(volume_script, {
      stdout = function(line)
        emit_volume_info_pulse()
      end
    })
  end)
end
