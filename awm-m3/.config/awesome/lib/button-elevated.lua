local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/m3/pages/common-buttons/specs/#0eea2a85-b4d7-4c74-b08e-98410b9412c7
local button = class()

function button:init(args)
  self.args = args or {}
  self.icon = self.args.icon or nil
  self.text = self.args.text or nil
  self.color = self.args.color or md.sys.color.primary
  self.cmd = self.args.cmd or nil
  self.state = self:state()
  self.surface = self:surface()
  self.widget = self:elevated()
  self:signals()
  return self.widget
end

function button:elevated()
  return wibox.widget {
    {
      {
        {
          {
            self:make_icon(),
            self:make_text(),
            spacing = self.text and dpi(8) or 0,
            layout = wibox.layout.fixed.horizontal
          },
          widget = self:layout()
        },
        widget = self.state
      },
      widget = self.surface
    },
    widget = self:container()
  }
end

function button:make_icon()
  if not self.icon then return nil end
  return wibox.widget {
    text = self.icon,
    align = 'center',
    font = md.sys.typescale.icon.font .. ' ' .. dpi(18),
    widget = wibox.widget.textbox
  }
end

function button:make_text()
  if not self.text then return nil end
  return wibox.widget {
    text = self.text,
    align = 'center',
    font = md.sys.typescale.body_medium.font .. ' ' .. dpi(14),
    widget = wibox.widget.textbox
  }
end

function button:container()
  return wibox.widget {
    fg = self.color,
    bg = md.sys.color.surface,
    widget = wibox.container.background
  }
end

function button:surface()
  return wibox.widget {
    bg = md.sys.color.surface_tint_color
      .. md.sys.elevation.level1,
    shape = helpers.rrect(dpi(20)),
    widget = wibox.container.background
  }
end

function button:layout()
  return wibox.widget {
    top = dpi(10),
    bottom = dpi(10),
    left = dpi(18),
    right = dpi(18),
    widget = wibox.container.margin
  }
end

function button:state()
  return wibox.widget {
    shape = helpers.rrect(dpi(20)),
    widget = wibox.container.background
  }
end

function button:signals()
  self.state:connect_signal('mouse::enter', function()
    self.state.bg = self.color
      .. md.sys.state.hover_state_layer_opacity
    self.surface = self.color
      .. md.sys.elevation.level2
  end)
  self.state:connect_signal('mouse::leave', function()
    self.state.bg = self.color .. '00'
    self.surface = self.color
      .. md.sys.elevation.level1
  end)
  self.widget:connect_signal('button::press', function()
    if self.cmd and type(self.cmd) == 'function' then
      self.cmd()
    end
  end)
end

return button
