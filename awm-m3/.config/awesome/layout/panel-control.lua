local wibox = require('wibox')

local control = class()

function control:init()
  return wibox.widget {
    require('widgets.cpu')(),
    layout = wibox.layout.fixed.vertical
  }
end

return control
