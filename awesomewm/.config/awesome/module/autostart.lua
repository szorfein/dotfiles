local app = require("util.app")
local spawn = require('awful.spawn')
local beautiful = require('beautiful')
local naughty = require('naughty')

app.run_once({'picom -b'})
app.run_once({'ncmpcpp'}, true, 'music_n')
app.run_once({'cava'}, true, 'music_c')
app.run_once({'tmux'}, true, 'music_t')
app.run_once({'neomutt'}, true, 'mail')

local update_lock = [[
  betterlockscreen -u ]] .. beautiful.wallpaper .. [[
]]

spawn.easy_async_with_shell(update_lock, function(_, _, _, exit_code)
  if exit_code ~= 0 then
    naughty.notify({ title = 'app lock', text = 'Err with betterlockscreen.' })
  end
end)
