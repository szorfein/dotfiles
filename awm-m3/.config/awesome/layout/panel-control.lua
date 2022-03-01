local wibox = require('wibox')

local control = class()

function control:init()
  return wibox.widget {
    self:centered({
      require('widgets.brightness')({}),
      require('widgets.volume')({})
    }),
    self:centered({
      require('widgets.cpu')({ w = dpi(80), h = dpi(80) }),
      require('widgets.mem')({ w = dpi(80), h = dpi(80) })
    }),
    self:centered({
      require('widgets.quit')(),
    }),
    spacing = dpi(14),
    layout = wibox.layout.fixed.vertical
  }
end

function control:centered(widgets)
  local widget = wibox.widget {
    spacing = dpi(8),
    layout = wibox.layout.fixed.horizontal
  }
  for _,v in ipairs(widgets) do widget:add(v) end
  return wibox.widget {
    nil,
    {
      widget,
      layout = wibox.layout.fixed.horizontal
    },
    expand = 'none',
    layout = wibox.layout.align.horizontal
  }
end

return control
