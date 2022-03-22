local awful = require('awful')
local timer = require('gears.timer')

local function mpd_status()
  local script = [[ sh -c '
    pgrep -x mpd
  ']]

  awful.spawn.easy_async_with_shell(script, function(_, _, _, exit_code)
    local status = exit_code == 0 and true or false

    awesome.emit_signal('daemon::mpd', status)
  end)
end

timer {
  timeout = 10,
  autostart = true,
  call_now = true,
  callback = function()
    mpd_status()
  end
}
