local awful = require("awful")
local beautiful = require("beautiful")

-- init table
local mywallpaper = class()

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    awful.spawn.with_shell("feh --bg-fill " .. wallpaper)
  end
end

function mywallpaper:init(s)
  set_wallpaper(s)

  -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
  screen.connect_signal("property::geometry", set_wallpaper)
end

return mywallpaper
