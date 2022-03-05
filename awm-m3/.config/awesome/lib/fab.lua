local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/m3/pages/common-buttons/specs/#0eea2a85-b4d7-4c74-b08e-98410b9412c7
local button = class()

function button:init(args)
  self.args = args or {}
  self.icon = self.args.icon or nil
  self.fg = self.args.color or md.sys.color.on_primary_container
  self.bg = self.args.color or md.sys.color.primary_container
  self.cmd = self.args.cmd or nil
  self.state = self:state()
  self.surface = self:surface()
  self.widget = self:fab()
  self:signals()
  return self.widget
end

function button:fab()
  return wibox.widget {
    {
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
      widget = self.surface
    },
    widget = self:container()
  }
end

function button:make_icon()
  return wibox.widget {
    text = self.icon,
    align = 'center',
    valign = 'center',
    font = md.sys.typescale.icon.font .. ' ' .. dpi(24),
    widget = wibox.widget.textbox
  }
end

function button:container()
  return wibox.widget {
    fg = self.color,
    bg = self.bg,
    shape = helpers.rrect(dpi(16)),
    widget = wibox.container.background
  }
end

function button:surface()
  return wibox.widget {
    bg = self.fg
      .. md.sys.elevation.level3,
    shape = helpers.rrect(dpi(16)),
    widget = wibox.container.background
  }
end

function button:layout()
  return wibox.widget {
    margins = dpi(16),
    forced_height = dpi(56),
    widget = wibox.container.margin
  }
end

function button:state()
  return wibox.widget {
    shape = helpers.rrect(dpi(16)),
    widget = wibox.container.background
  }
end

function button:signals()
  self.state:connect_signal('mouse::enter', function()
    self.state.bg = self.fg
      .. md.sys.state.hover_state_layer_opacity
    self.surface = self.fg
      .. md.sys.elevation.level4
  end)
  self.state:connect_signal('mouse::leave', function()
    self.state.bg = self.fg .. md.sys.elevation.level0
    self.surface = self.fg
      .. md.sys.elevation.level3
  end)
  self.widget:connect_signal('button::press', function()
    if self.cmd and type(self.cmd) == 'function' then
      self.cmd()
    end
  end)
end

return button
