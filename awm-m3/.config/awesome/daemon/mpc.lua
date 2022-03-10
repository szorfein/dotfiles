local awful = require('awful')
local timer = require('gears.timer')

local script = [[
#!/usr/bin/env sh

set -o errexit -o nounset

MUSIC_DIR="$HOME/musics"
IMG="$HOME/images/thumb-1920-609120.jpg"
CURR=$(mpc current)

if [ -z "$CURR" ] ; then
  exit 1
fi

FILE=$(mpc -f %file% | head -1)
FILE_DIR=$(echo "$MUSIC_DIR/$FILE" | sed 's|\(.*\)/.*|\1|')
FIND=$(find "$FILE_DIR" -type f -name '*.jpg' -o -name '*.png')

if [ "$?" -eq 0 ] ; then
  IMG="${FIND}"
fi

mpc_output=$(mpc -f ARTIST@%artist%@TITLE@%title%@FILE@%file%@)
echo "IMG@${IMG}@$mpc_output"
]]

local function mpc_info()
  awful.spawn.easy_async_with_shell(script, function(stdout, _, _, exit_code)
    if exit_code ~= 0 then
      awesome.emit_signal("daemon::mpc",
        '/home/daggoth/images/thumb-1920-609120.jpg', 'N/A', 'N/A', true)
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
    local naughty = require('naughty')
    naughty.notify({ title = 'MPD', text = 'change' })

    awesome.emit_signal("daemon::mpc", img, artist, title, paused)
  end)
end

mpc_info()

local mpc_script = [[ sh -c '
mpc idleloop player
']]

awful.spawn.easy_async_with_shell(
  "pgrep -f \"mpc idleloop player\" | xargs kill", function()
  awful.spawn.with_line_callback(mpc_script, {
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
