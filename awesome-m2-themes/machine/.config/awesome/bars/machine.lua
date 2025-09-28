local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local separators = require('util.separators')

-- widgets load
local scrot = require("widgets.scrot")

-- {{{ Wibar
local mybar = class()

-- Add the bar on each screen
function mybar:init(s)

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = require("widgets.layoutbox")(s, {})
  --
  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a taglist for each screen
  s.mytaglist = require("widgets.taglist")(s, { mode = "text", layout = "vertical" })

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ position = beautiful.wibar_position, width = beautiful.wibar_size, screen = s })
  s.mywibox.bg = beautiful.wibar_bg or M.x.background

  -- Add widgets to the wibox
  s.mywibox:setup {
    { -- Left widgets
      nil,
      {
        require("widgets.launcher")(),
        layout = wibox.layout.fixed.vertical
      },
      nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    { -- More or less Middle
      s.mytaglist,
      layout = wibox.layout.fixed.vertical  
    },
    { -- Right widgets
      nil,
      {
        require("widgets.change_theme"),
        scrot,
        s.mylayoutbox,
        layout = wibox.layout.fixed.vertical,
      },
      nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    expand ="none",
    layout = wibox.layout.align.vertical
  }
end

return mybar
