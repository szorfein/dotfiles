local spawn = require('awful.spawn')
local timer = require("gears.timer")
local noti = require('utils.noti')
local icons = require("icons.default")

local start = true
local msg_old = ""

local function music_cover()
  local script = [[
    MUSIC_DIR=$HOME/musics
    CURR=$(mpc --format "%file%" current)
    DIR="${CURR%/*}"

    covers=$(find "$MUSIC_DIR/$DIR" -maxdepth 1 -regex '.*\.\(jpe?g\|png\)' | head -n 1)

    [ -f "$covers" ] || exit
    echo "$covers"
  ]]

  spawn.easy_async_with_shell(script, function(stdout)

    local cover = icons["default_cover"]
    if not (stdout == nil or stdout == '') then
      cover = stdout:gsub('%\n', '')
    end

    --noti.info("cover -> ".. cover)
    awesome.emit_signal("daemon::mpd_cover", cover)
  end)
end

local music_infos = function()
  spawn.easy_async_with_shell([[ mpc -f %title%@@%artist%@ current ]], function(stdout)

    local title = stdout:match('(.*)@@') or ''
    local artist = stdout:match('@@(.*)@') or ''

    title = title:gsub('%\n', '')
    artist = artist:gsub('%\n', '')

    if not (title == '' or artist == '') then
      local icon = "<span foreground='" .. M.x.primary .. "'> ♫  </span>"
      local msg = icon .. tostring(title:sub(1, 20)) .. " by " .. tostring(artist)
      if not start and msg ~= msg_old then noti.info(msg) end
      msg_old = msg
    end

    awesome.emit_signal("daemon::mpd_infos", title, artist)
    start = false
  end)
end

local function music_time()
  spawn.easy_async_with_shell([[
    mpc status | awk 'NR==2 { split($4, a); print a[1]}' | tr -d '[\%\(\)]'
  ]], function(stdout)

    local time = 0
    if stdout ~= nil then
      time = tonumber(stdout)
    end

    awesome.emit_signal("daemon::mpd_time", time)
  end)
end

local function update_all()
  music_infos()
  music_cover()
end

-- update time separately
timer {
  timeout = 5, autostart = true, call_now = true,
  callback = function()
    music_time()
  end
}

-- init once
update_all()

local mpd_event_listener = [[
  mpc idleloop player
]]

local kill_mpd_event_listener = [[
  for pid in $(pgrep -fx "mpc idleloop player") ; do
    kill "$pid" >/dev/null
  end
]]

spawn.easy_async_with_shell(kill_mpd_event_listener, function()
  spawn.with_line_callback(mpd_event_listener, {
    stdout = function(line)
      update_all()
    end
  })
end)
