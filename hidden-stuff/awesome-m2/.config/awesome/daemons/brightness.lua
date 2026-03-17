-- Create a signal: daemon::brightness 
-- return value: brightness
local spawn = require("awful.spawn")
local noti = require("utils.noti")

local val = 1
local start = true

local brightness_subscribe_script = [[
  sh -c "
    while (inotifywait -e modify /sys/class/backlight/?**/brightness -qq) ; do echo ; done
  "
]]

local brightness_script = [[
  sh -c "
    light -G
  "
]]

local emit_brightness_info = function()
  spawn.with_line_callback(brightness_script, {
    stdout = function(line)
      local percentage = math.floor(tonumber(line))
      awesome.emit_signal("daemon::brightness", percentage)
      if val ~= percentage and not start then
        local icon = "<span foreground='" .. M.x.primary .. "'>  </span>"
        noti.info(icon .. tostring(percentage) .. "%")
      end
      start = false
      val = percentage
    end
  })
end

-- Run once to initialize widgets
emit_brightness_info()

-- Kill old inotifywait process
spawn.easy_async_with_shell("pgrep -i inotifywait | xargs kill", function()
  -- Update brightness status with each line printed
  spawn.with_line_callback(brightness_subscribe_script, {
    stdout = function(_)
      emit_brightness_info()
    end
  })
end)
