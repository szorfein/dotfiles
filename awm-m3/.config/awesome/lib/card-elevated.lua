local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/components/cards/specs
local card = class()

function card:init()
end

function card:elevated(widget)
  return wibox.widget {
    {
      {
        widget,
        margins = dpi(16),
        widget = wibox.container.margin
      },
      bg = md.sys.color.surface_tint_color .. md.sys.elevation.level1,
      shape = helpers.rrect(dpi(12)),
      widget = wibox.container.background
    },
    bg = md.sys.color.surface,
    widget = wibox.container.background
  }
end

return card
