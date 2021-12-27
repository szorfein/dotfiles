local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require('util.widgets')

-- widgets load
local tor = require("widgets.button_tor")
local tagslist = require("taglists.anonymous")

-- {{{ Redefine widgets with a background
local mpc = require("widgets.mpc")({})
local my_mpc = widget.bg_rounded( beautiful.background, "#3b6f6f", mpc )

local volume = require("widgets.volume")({})
local my_vol = widget.bg_rounded( beautiful.background, "#5b8f94", volume )

local mail = require("widgets.mail")
local my_mail = widget.bg_rounded( beautiful.background, "#567092", mail )

local ram = require("widgets.ram")({})
local my_ram = widget.bg_rounded( beautiful.background, "#524e87", ram )

local battery = require("widgets.battery")({})
local my_battery = widget.bg_rounded( beautiful.background, "#794298", battery )

local date = require("widgets.date")
local my_date = widget.bg_rounded( beautiful.background, "#873075", date_widget )

local launcher = require("widgets.launcher")()
local my_launcher = widget.bg_rounded( M.x.on_background .. "0E", "#20252c", launcher, "button" )

-- widget redefined }}}

local mybar = class()

-- {{{ Wibar
function mybar:init(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create a tasklist widget for each screen
  s.mytasklist = require("widgets.tasklist")(s)

  --s.mytaglist = require("taglists.anonymous")(s, {mode = "icon", want_layout = "grid"}
  s.mytaglist = require("taglists.anonymous")

-- For look like a detached bar, we have to add a fake invisible bar...
  self.size = beautiful.wibar_size or dpi(56)
  self.position = beautiful.wibar_position or "top"

  s.useless_wibar = awful.wibar({ position = self.position, height = beautiful.screen_margin * 2, opacity = 0, screen = s })

  -- Create the wibox with default options
  s.mywibox = awful.wibar({ height = self.size, width = beautiful.wibar_width, screen = s })
  s.mywibox.bg = M.x.background .. 00

-- Add widgets to the wibox
s.mywibox:setup {
  layout = wibox.layout.align.horizontal,
  spacing = dpi(9),
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      spacing = 12,
      my_launcher,
      s.mytaglist,
      --s.mypromptbox,
      --distrib_icon,
      wibox.widget.systray(),
    },
    { -- middle
      layout = wibox.layout.fixed.horizontal,
      s.mytasklist
    },
    { -- right
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(8),
      tor,
      my_mpc,
      my_vol,
      my_mail,
      my_ram,
      my_battery,
      my_date,
      require("widgets.change_theme")
    }
  }
end

return mybar
