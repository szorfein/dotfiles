local wibox = require('wibox')
local helpers = require('lib.helpers')

local volume = class()

function volume:init()
  return wibox.widget {
    {
      value = 30,
      max_value = 100,
      color = md.sys.color.secondary,
      background_color = md.sys.color.on_surface .. md.sys.elevation.level1,
      shape = helpers.rrect(dpi(26)),
      widget = wibox.widget.progressbar,
    },
    forced_height = 100,
    forced_width  = 20,
    direction     = 'east',
    layout        = wibox.container.rotate,
  }
end

return volume
