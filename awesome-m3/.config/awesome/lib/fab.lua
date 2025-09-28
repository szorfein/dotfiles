local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/components/extended-fab/specs
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
            nil,
          self:make_icon(),
          expand = 'none',
          layout = wibox.layout.align.horizontal
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
    valign = 'center',
    font = md.sys.typescale.icon.font .. ' ' .. dpi(16),
    forced_width = dpi(24),
    forced_height = dpi(24),
    widget = wibox.widget.textbox
  }
end

function button:container()
  return wibox.widget {
    fg = self.color,
    bg = self.bg,
    shape = helpers.rrect(dpi(16)),
    --forced_height = dpi(56),
    widget = wibox.container.background
  }
end

function button:surface()
  return wibox.widget {
    bg = md.sys.color.surface_tint_color
      .. md.sys.elevation.level3,
    shape = helpers.rrect(dpi(16)),
    widget = wibox.container.background
  }
end

function button:layout()
  return wibox.widget {
    margins = dpi(14),
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
    self.surface = md.sys.color.surface_tint_color
      .. md.sys.elevation.level4
  end)
  self.state:connect_signal('mouse::leave', function()
    self.state.bg = self.fg .. md.sys.elevation.level0
    self.surface = md.sys.color.surface_tint_color
      .. md.sys.elevation.level3
  end)
  self.widget:connect_signal('button::press', function()
    if self.cmd and type(self.cmd) == 'function' then
      self.cmd()
    end
  end)
end

return button
