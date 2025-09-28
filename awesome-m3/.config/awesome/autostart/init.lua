local awful = require('awful')
local app = require('lib.app')
local naughty = require('naughty')

local script = [[
#!/usr/bin/env sh

set -o errexit

userresources="$HOME"/.Xresources

if [ -f "$userresources" ]; then
  if [ -f /usr/bin/cpp ] ; then
    xrdb -merge -cpp /usr/bin/cpp "$userresources"
  else
    xrdb -merge "$userresources"
  fi
fi

if ! light -I ; then light -O ; fi
if ! pgrep -i picom ; then picom -b ; fi
]]

awful.spawn.easy_async_with_shell(script, function(_, _, _, exit_code)
  if exit_code ~= 0 then
    naughty.notify({ title = 'Requirement', text = 'err' })
  end
end)

local update_lock = [[
  betterlockscreen -u ]] .. md.wallpaper .. [[
]]

awful.spawn.easy_async_with_shell(update_lock, function(_, _, _, exit_code)
  if exit_code ~= 0 then
    naughty.notify({ title = 'app lock', text = 'Err with betterlockscreen.' })
  end
end)

-- spawn xss-lock with i3lock
awful.spawn.easy_async_with_shell('pgrep -i xss | xargs kill', function()
  app:lock_with_xss()
end)
