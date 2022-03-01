local wibox = require('wibox')
local button = require('lib.button-elevated')

local quit = class()

function quit:init()
  return wibox.widget {
    self:restart(),
    self:lock(),
    self:poweroff(),
    spacing = dpi(8),
    widget = wibox.layout.fixed.horizontal
  }
end

function quit:restart()
  return button({
    icon = '󰜉',
    color = md.sys.color.secondary,
    cmd = awesome.restart
  })
end

function quit:lock()
  return button({
    icon = '󰌾',
  })
end

function quit:poweroff()
  return button({
    icon = '󰤆',
    color = md.sys.color.error
  })
end

return quit
