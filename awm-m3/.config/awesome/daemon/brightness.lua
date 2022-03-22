local spawn = require("awful.spawn")

local brightness_subscribe_script = [[ sh -c '
while (inotifywait -e modify /sys/class/backlight/?**/brightness -qq) do
  echo
  sleep 1
done
']]

local script = [[ sh -c '
light -G
']]

-- To avoid a screen full black
local function brightness_minimum_value()
  spawn('light -N 1')
end

local function brightness_status()
  spawn.easy_async_with_shell(script, function(stdout)
    percentage = math.floor(tonumber(stdout))
    awesome.emit_signal('daemon::brightness', percentage)
  end)
end

brightness_minimum_value()
brightness_status()

spawn.easy_async_with_shell('pgrep -i inotifywait | xargs kill', function()
  spawn.with_line_callback(brightness_subscribe_script, {
    stdout = function(_)
      brightness_status()
    end
  })
end)
