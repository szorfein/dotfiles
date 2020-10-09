local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- init tables
local mybar = class()

-- {{{ Wibar
function mybar:init(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a tasklist widget for each screen
  s.mytasklist = require("widgets.tasklist")(s)

  -- Create a taglist widget for each screen
  s.mytaglist = require("widgets.taglist")(s, { mode = "line", layout = 'flex' })

  -- Create the wibox with default options
  self.height = beautiful.wibar_height or dpi(56)
  self.position = beautiful.wibar_position or "top"

  s.mywibox = awful.wibar({ position = self.position, height = self.height, screen = s })
  s.mywibox.bg = beautiful.wibar_bg or M.x.background

  -- Add widgets to the wibox
  s.mywibox:setup {
    {
      require("widgets.launcher")(),
      layout = wibox.layout.fixed.horizontal
    },
    s.mytasklist, -- middle
    {
      require("widgets.change_theme"),
      require("widgets.settings")(),
      require("widgets.layoutbox")(),
      spacing = dpi(8),
      layout = wibox.layout.fixed.horizontal
    },
    --expand ="none",
    layout = wibox.layout.align.horizontal
  }

  -- tagslist bar
  s.mywibox_tags = awful.wibar({ screen = s, position = "top", height = dpi(5), bg = beautiful.wibar_bg, screen = s })
  awful.placement.maximize_horizontally(s.mywibox_tags)

  s.mywibox_tags:setup {
    widget = s.mytaglist
  }
end

return mybar
