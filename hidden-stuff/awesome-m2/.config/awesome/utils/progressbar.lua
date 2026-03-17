local wibox = require("wibox")

local progressbar = {}

function progressbar.horiz(color)
  local color = color or M.x.primary
  return wibox.widget {
    max_value = 100,
    value = 0,
    forced_height = dpi(6),
    border_color = M.x.surface,
    color = color,
    background_color = color .. "66", -- 40%
    widget = wibox.widget.progressbar
  }
end

return progressbar
