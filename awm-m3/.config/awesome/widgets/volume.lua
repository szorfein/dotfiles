local wibox = require('wibox')
local helpers = require('lib.helpers')
local slider = require('lib.slider')({ fg = md.sys.color.primary })

local volume = class()

function volume:init()
  self.slider = slider:widget()
  self.widget = self:create()
  slider:set(20)
  return self.widget
end

function volume:create()
  return wibox.widget {
    self.slider,
    forced_height = 100,
    forced_width  = 20,
    direction     = 'east',
    layout        = wibox.container.rotate,
  }
end

return volume
