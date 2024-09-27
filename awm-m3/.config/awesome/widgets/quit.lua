local wibox = require('wibox')
local spawn = require('awful.spawn')
local naughty = require('naughty')
local button = require('lib.button-outlined')
local button_filled = require('lib.button-filled')
local awful = require('awful')

local quit = class()

-- code nerd icon: echo -e "\U<code>"
function quit:init()
  return wibox.widget {
    self:dashboard(),
    self:restart(),
    self:lock(),
    self:poweroff(),
    spacing = dpi(14),
    widget = wibox.layout.fixed.vertical
  }
end

function quit:dashboard()
  return button({
      icon = '󱒉',
      cmd = function()
        awful.screen.focused().dashboard.visible = true
      end
  })
end

function quit:restart()
  return button({
    icon = '󰜉',
    cmd = awesome.restart
  })
end

function quit:lock()
  return button({
    icon = '󰻛',
    cmd = function()
      spawn.easy_async_with_shell('maim ~/$(date +%s).png -d 1.0', function(_, stderr, _, exit_code)
        if exit_code == 0 then
          naughty.notify({ text = 'Screenshot taken' })
        else
          naughty.notify({ text = stderr })
        end
      end)
    end
  })
end

function quit:poweroff()
  return button_filled({
    icon = '󰤆',
    cmd = function() logout_display() end
  })
end

return quit
