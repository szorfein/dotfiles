local wibox = require('wibox')
local helpers = require('lib.helpers')
local slider = require('lib.slider')()

local brightness = class()

function brightness:init()
  self.slider = slider:widget()
  self.widget = self:create()
  slider:set(40)
  return self.widget
end

function brightness:create()
  return wibox.widget {
    self.slider,
    forced_height = 100,
    forced_width  = 20,
    direction     = 'east',
    layout        = wibox.container.rotate,
  }
end

return brightness
