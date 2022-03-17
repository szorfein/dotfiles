local wibox = require('wibox')
local button = require('lib.button-elevated')
local button_filled = require('lib.button-filled')
local app = require('lib.app')

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
    cmd = app.lock
  })
end

function quit:poweroff()
  return button_filled({
    icon = '󰤆',
    fg = md.sys.color.surface,
    bg = md.sys.color.on_surface,
    cmd = function() logout_display() end
  })
end

return quit
