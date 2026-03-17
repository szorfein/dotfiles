local wibox = require("wibox")
local beautiful = require("beautiful")
local helper = require("utils.helper")

beautiful.slider_bar_height = dpi(6)
beautiful.slider_handle_width = dpi(20)
beautiful.slider_handle_shape = helper.rrect(20)

local slider = {}

function slider.horiz(color)
  local color = color or M.x.primary
  return wibox.widget {
    maximum = 100,
    value = 0,
    forced_height = dpi(6),
    border_color = M.x.surface,
    handle_color = color,
    bar_color = color .. "66", -- background 40%
    widget = wibox.widget.slider,
  }
end

return slider
