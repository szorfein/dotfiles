local wibox = require("wibox")
local beautiful = require("beautiful")

local layouts = {}

function layouts.create_titlebar(c, titlebar_buttons, titlebar_position, titlebar_size)
  awful.titlebar(c, {font = beautiful.titlebar_font, position = titlebar_position, size = titlebar_size}) : setup {
    { 
      buttons = titlebar_buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { 
      buttons = titlebar_buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    {
      buttons = titlebar_buttons,
      layout = wibox.layout.fixed.horizontal
    },
    layout = wibox.layout.align.horizontal
  }
end

return layouts
