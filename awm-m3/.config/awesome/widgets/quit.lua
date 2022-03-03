local wibox = require('wibox')
local button = require('lib.button-elevated')
local button_filled = require('lib.button-filled')

local quit = class()

function quit:init()
  return wibox.widget {
    self:restart(),
    self:lock(),
    self:poweroff(),
    spacing = dpi(28),
    widget = wibox.layout.fixed.vertical
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
  return button_filled({
    icon = '󰤆',
    fg = md.sys.color.surface,
    bg = md.sys.color.on_surface,
    --color = md.sys.color.error
  })
end

return quit
