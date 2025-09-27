local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- init tables
local mybar = class()

-- {{{ Wibar
function mybar:init(s)

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = require("widgets.layoutbox")(s, {})

  -- Create a taglist widget
  s.mytaglist = require("widgets.mini-taglist")(s, {})

  -- Create a tasklist widget for each screen
  s.mytasklist = require("widgets.tasklist")(s)

  -- Create a taglist widget for each screen
  s.mytaglist = require("widgets.taglist")(s, { mode = "line", layout = 'flex' })

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ position = beautiful.wibar_position, height = beautiful.wibar_size, bg = beautiful.wibar_bg, screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    { -- Left widgets
      require("widgets.launcher")(),
      layout = wibox.layout.fixed.horizontal
    },
    s.mytasklist, -- More or less Middle
    { -- Right widgets
      require("widgets.change_theme"),
      require("widgets.settings")(),
      s.mylayoutbox,
      spacing = dpi(5),
      layout = wibox.layout.fixed.horizontal
    },
    expand ="none",
    layout = wibox.layout.align.horizontal
  }

  -- tagslist bar
  s.mywibox_tags = awful.wibar({ position = beautiful.wibar_position, height = dpi(5), bg = beautiful.wibar_bg, screen = s })
  awful.placement.maximize_horizontally(s.mywibox_tags)

  s.mywibox_tags:setup {
    widget = s.mytaglist
  }
end

return mybar
