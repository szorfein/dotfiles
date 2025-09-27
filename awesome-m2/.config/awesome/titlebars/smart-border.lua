local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local smartBorders = require("util.smart-borders")
local font = require("util.font")
local titlebar = require("util.titlebar")

-- vars
local position = beautiful.titlebar_position or 'top'
local t_font = M.f.subtile_1

client.connect_signal("request::titlebars", function(c)

  awful.titlebar(c, 
    { size = beautiful.titlebar_size, font = t_font, position = position }
  ) : setup {
    nil, -- Left
    { -- Middle
      -- Title
      nil,
      buttons = titlebar.button(c),
      layout = wibox.layout.flex.horizontal
    },
    { -- Right
      titlebar.button_minimize(c),
      titlebar.button_maximize(c),
      titlebar.button_close(c),
      layout = wibox.layout.fixed.horizontal
    },
    layout = wibox.layout.align.horizontal
  }

  -- bottom bar for ncmpcpp
  if c.class == "music_n" then
    titlebar.ncmpcpp(c)
  end

  -- Add the smart_border
  smartBorders.set(c, true)
end)

client.connect_signal("property::size", smartBorders.set)
