local awful = require('awful')
local timer = require('gears.timer')
local beautiful = require('beautiful')

local script = [[
#!/usr/bin/env sh

set -o errexit -o nounset

MUSIC_DIR="$HOME/musics"
IMG="]].. beautiful.wallpaper ..[["
CURR=$(mpc current)

[ -z "$CURR" ] && exit 1

FILE=$(mpc -f %file% | head -1)
FILE_DIR="$MUSIC_DIR/${FILE%/*}"
# TODO: should we write a script to convert all webp in jpg or png ??
FIND=$(find "$FILE_DIR" -regex ".*\.\(jpg\|png\|jpeg\)")

[ -n "$FIND" ] && IMG="${FIND}"

mpc_output=$(mpc -f ARTIST@%artist%@TITLE@%title%@FILE@%file%@)

echo "IMG@${IMG}@$mpc_output"
]]

local function mpc_info()
  awful.spawn.easy_async_with_shell(script, function(stdout, _, _, exit_code)
    if exit_code ~= 0 then
      awesome.emit_signal("daemon::mpc", beautiful.wallpaper, 'N/A', 'N/A', true)
    end

    local img = stdout:match('^IMG@(.*)@ARTIST')
    local artist = stdout:match('ARTIST@(.*)@TITLE')
    local title = stdout:match('@TITLE@(.*)@FILE')
    local status = stdout:match('\n%[(.*)%]')

    local paused
    if status == "playing" then
      paused = false
    else
      paused = true
    end

    awesome.emit_signal("daemon::mpc", img, artist, title, paused)
  end)
end

mpc_info()

awful.spawn.easy_async_with_shell(
  "pgrep -f \"mpc idleloop player\" | xargs kill", function()
  awful.spawn.with_line_callback("mpc idleloop player", {
    stdout = function()
      mpc_info()
    end
  })
end)

local function mpc_time()
  awful.spawn.easy_async_with_shell('mpc', function(stdout)
    local time = stdout:match('.*%((.*)%%%)')
    awesome.emit_signal('daemon::mpc_timer', time)
  end)
end

timer {
  timeout = 6,
  autostart = true,
  call_now = true,
  callback = function()
    mpc_time()
  end
}
