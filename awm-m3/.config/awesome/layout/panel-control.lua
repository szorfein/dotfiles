local wibox = require('wibox')

local control = class()

function control:init()
  return wibox.widget {
    {
      nil,
      {
        require('widgets.brightness')({}),
        require('widgets.volume')({}),
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal
      },
      expand = 'none',
      layout = wibox.layout.align.horizontal
    },
    {
      nil,
      {
        require('widgets.cpu')({ w = dpi(80), h = dpi(80) }),
        require('widgets.mem')({ w = dpi(80), h = dpi(80) }),
        layout = wibox.layout.fixed.horizontal
      },
      expand = 'none',
      layout = wibox.layout.align.horizontal
    },
    layout = wibox.layout.fixed.vertical
  }
end

return control
