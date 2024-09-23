local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/components/buttons/specs
-- Elevated button

local button = class()

function button:init(args)
  self.args = args or {}
  self.icon = self.args.icon or nil
  self.text = self.args.text or nil
  self.color = self.args.color or md.sys.color.primary
  self.cmd = self.args.cmd or nil
  self.size = args.size or dpi(18)
  self.layout = self.args.layout or wibox.layout.fixed.horizontal
  self:state()
  self:container_elevation()
  self:make_widget()
  self:signals()
  return self.widget
end

function button:make_widget()
  self.widget = wibox.widget {
    {
      {
        {
          {
            self:make_icon(),
            self:make_text(),
            spacing = self.text and dpi(8) or 0,
            layout = self.layout
          },
          widget = self:margin()
        },
        widget = self.state
      },
      widget = self.container_elevation
    },
    widget = self:container()
  }
end

function button:make_icon()
  if not self.icon then return nil end

  return wibox.widget {
    text = self.icon,
    align = 'center',
    font = md.sys.typescale.icon.font .. ' ' .. self.size,
    widget = wibox.widget.textbox
  }
end

function button:make_text()
  if not self.text then return nil end

  return wibox.widget {
    text = self.text,
    align = 'center',
    font = md.sys.typescale.label_large.font .. ' ' .. dpi(14),
    widget = wibox.widget.textbox
  }
end

function button:container()
  return wibox.widget {
    fg = self.color,
    bg = md.sys.color.surface_container_low,
    --forced_height = dpi(40),
    shape = helpers.rrect(dpi(20)),
    widget = wibox.container.background
  }
end

function button:container_elevation()
  self.container_elevation = wibox.widget {
    bg = md.sys.color.surface_tint_color
      .. md.sys.elevation.level1,
    shape = helpers.rrect(dpi(20)),
    widget = wibox.container.background
  }
end

function button:margin()
  return wibox.widget {
    top = dpi(10),
    bottom = dpi(10),
    left = dpi(18),
    right = dpi(18),
    widget = wibox.container.margin
  }
end

function button:state()
  self.state = wibox.widget {
    bg = self.color .. '00',
    shape = helpers.rrect(dpi(20)),
    widget = wibox.container.background
  }
end

function button:signals()
  self.widget:connect_signal('mouse::enter', function()
    self.state.bg = self.color
      .. md.sys.state.hover_state_layer_opacity
    self.container_elevation.bg = md.sys.color.surface_tint_color
      .. md.sys.elevation.level2
  end)
  self.widget:connect_signal('mouse::leave', function()
    self.state.bg = self.color .. '00'
    self.container_elevation.bg = md.sys.color.surface_tint_color
      .. md.sys.elevation.level1
  end)
  self.widget:connect_signal('button::press', function()
    if self.cmd and type(self.cmd) == 'function' then
      self.cmd()
    end
  end)
end

return button
