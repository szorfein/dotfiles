local gears = require('gears')

local helpers = {}

function helpers:rrect(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

return helpers
