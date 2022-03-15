local awful = require('awful')
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

light -I

if ! pgrep -i picom ; then picom -b ; fi
]]

awful.spawn.easy_async_with_shell(script, function(_, _, _, exit_code)
  if exit_code ~= 0 then
    naughty.notify({ title = 'Requirement', text = 'err' })
  end
end)
