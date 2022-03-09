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

function helpers:file_exist(file)
  local f = io.open(file, 'r')
  if f then
    f:close()
    return true
  end
  return false
end

return helpers
