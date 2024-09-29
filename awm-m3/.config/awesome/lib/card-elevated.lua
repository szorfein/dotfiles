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
      widget = self:container_elevation()
    },
    widget = self:container()
  }
end

function card:container_elevation()
    return wibox.widget {
      bg = md.sys.color.surface_tint_color .. md.sys.elevation.level1,
      shape = helpers:rrect(dpi(12)),
      widget = wibox.container.background
    }
end

function card:container()
    return wibox.widget {
      bg = md.sys.color.surface_container_low,
      shape = helpers:rrect(dpi(12)),
      widget = wibox.container.background
    }
end

return card
