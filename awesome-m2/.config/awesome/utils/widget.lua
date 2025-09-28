local wibox = require("wibox")

local widget = {}

function widget.centered(w, layout)
  local layout = layout or "horizontal"
  return wibox.widget {
    nil,
      w,
      expand = "none",
      layout = wibox.layout.align[layout]
  }
end

return widget
