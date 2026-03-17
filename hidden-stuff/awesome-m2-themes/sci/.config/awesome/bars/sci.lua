local awful = require("awful")
local wibox = require("wibox")

local mybar = class()

function mybar:init(s)

  local mytextclock = wibox.widget.textclock()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = require("widgets.layoutbox")(s, {})

  -- Create a taglist widget
  s.mytaglist = require("widgets.mini-taglist")(s, {})
 
  -- Create a tasklist widget
  s.mytasklist = require("widgets.mini-tasklist")(s, {})
  
  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", height = dpi(36), screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(4),
      require("widgets.launcher")(),
      s.mytaglist,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      require("widgets.change_theme"),
      require("widgets.settings")(),
      mytextclock,
      s.mylayoutbox
    }
  }
end

return mybar
