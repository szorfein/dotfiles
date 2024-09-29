local wibox = require('wibox')
local helpers = require('lib.helpers')
local gears = require('gears')

-- https://m3.material.io/components/icon-buttons/specs
-- Standard button

local button = class()

function button:init(args)
  self.args = args or {}
  self.icon = self.args.icon or nil
  self.fg = self.args.fg or md.sys.color.on_surface_variant
  self.cmd = self.args.cmd or nil
  self:state()
  self:container()
  self.widget = self:icon_button()
  self:signals()
end

function button:set_color(color_name)
  self.container.fg = color_name
  self.fg = color_name
end

function button:disable()
  self.container.fg = md.sys.color.on_surface
    .. md.sys.state.disable_content_opacity
end

function button:icon_button()
  return wibox.widget {
    {
      {
        {
          self:make_icon(),
          layout = wibox.layout.fixed.horizontal
        },
        widget = self:layout()
      },
      widget = self.state
    },
    widget = self.container
  }
end

function button:make_icon()
  if not self.icon then return nil end
  return wibox.widget {
    text = self.icon,
    font = md.sys.typescale.icon.font .. ' ' .. dpi(20),
    align = 'center',
    valign = 'center',
    forced_height = dpi(40),
    forced_width = dpi(40),
    widget = wibox.widget.textbox
  }
end

function button:container()
  self.container = wibox.widget {
    fg = self.fg,
    shape = gears.shape.circle,
    widget = wibox.container.background
  }
end

function button:layout()
  return wibox.widget {
    margins = dpi(6),
    widget = wibox.container.margin
  }
end

function button:state()
  self.state = wibox.widget {
    bg = self.fg .. md.sys.elevation.level0,
    shape = gears.shape.circle,
    widget = wibox.container.background
  }
end

function button:signals()
  self.widget:connect_signal('mouse::enter', function()
    self.state.bg = self.fg
      .. md.sys.state.hover_state_layer_opacity
  end)
  self.widget:connect_signal('mouse::leave', function()
    self.state.bg = self.fg .. '00'
  end)
  self.widget:connect_signal('button::press', function()
    if self.cmd and type(self.cmd) == 'function' then
      self.cmd()
    end
  end)
end

return button
