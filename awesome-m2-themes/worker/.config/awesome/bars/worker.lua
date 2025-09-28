local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local separators = require('util.separators')
local widget = require('util.widgets')

-- widgets load
local pad = separators.pad
local textclock = wibox.widget {
  font = M.f.body_2,
  format = '<span foreground="'..M.x.on_background..'">%H:%M</span>',
  widget = wibox.widget.textclock
}

-- init tables
local mybar = class()

-- {{{ Wibar
function mybar:init(s)

  -- We need one layoutbox per screen.
  s.mylayoutbox = require("widgets.layoutbox")(s, {})

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a tasklist widget for each screen
  --s.mytasklist = require("widgets.tasklist")(s)

  -- Create a taglist widget for each screen
  s.mytaglist = require("widgets.taglist")(s, { mode = "icon" })

  -- Create the wibox with default options
  self.height = beautiful.wibar_height or dpi(56)
  self.position = beautiful.wibar_position or "top"

  s.mywibox = awful.wibar({ position = self.position, height = self.height, screen = s })
  s.mywibox.bg = beautiful.wibar_bg or M.x.background

  -- Add widgets to the wibox
  s.mywibox:setup {
    { -- left
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10),
      require("widgets.launcher")(),
    },
    { -- middle
      {
        s.mytaglist,
        layout = wibox.layout.fixed.horizontal
      },
      margins = 2,
      widget = wibox.container.margin
    },
    { -- right
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10),
      require("widgets.change_theme"),
      layouts,
      require("widgets.settings")(),
      textclock,
      s.mylayoutbox
    },
    expand ="none",
    layout = wibox.layout.align.horizontal
  }
end

return mybar
