local gears = require('gears')

local helpers = {}

function helpers:rrect(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

function helpers:circle()
  return function(cr, width, height)
    gears.shape.circle(cr, width, height)
  end
end

return helpers
