local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/m3/pages/common-buttons/specs/#899b9107-0127-4a01-8f4c-87f19323a1b4

local text_button = class()

function text_button:init(args)
  self.prefix = args.prefix or nil
  self.content = args.content or ''
  self.cmd = args.cmd or nil
  self.fg = args.fg or md.sys.color.primary

  self.shape = helpers.rrect(dpi(20))

  self.colors = wibox.widget {
    bg = md.sys.color.surface,
    fg = self.fg,
    widget = wibox.container.background
  }

  self.states = wibox.widget {
    shape = self.shape,
    bg = md.sys.color.surface .. md.sys.elevation.level0,
    fg = self.fg,
    widget = wibox.container.background
  }

  self.margins = wibox.widget {
    left = dpi(12),
    right = self.prefix and dpi(16) or dpi(12),
    widget = wibox.container.margin
  }

  self.constraint = wibox.widget {
    forced_height = dpi(40),
    widget = wibox.container.constraint
  }

  self.w = wibox.widget {
    {
      {
        {
          {
            text = self.content,
            align = 'center',
            valign = 'center',
            font = md.sys.typescale.label_medium.font .. ' ' .. dpi(24),
            widget = wibox.widget.textbox
          },
          widget = self.constraint
        },
        widget = self.margins
      },
      widget = self.states
    },
    widget = self.colors
  }
end

function text_button:on_press()
  if self.cmd then
    self.w:connect_signal("button::press", function() self.cmd() end)
  end
end

function text_button:hover()
  self.w:connect_signal('mouse::enter', function()
    self.states.bg = self.fg .. md.sys.state.hover_state_layer_opacity
  end)
  self.w:connect_signal('mouse::leave', function()
    self.states.bg = self.fg .. md.sys.elevation.level0
  end)
end

function text_button:pressed()
  self.w:connect_signal('mouse::press', function()
    self.states.bg = self.fg .. md.sys.state.pressed_state_layer_opacity
  end)
end

local main = class(text_button)

function main:init(args)
  text_button.init(self, args)
  text_button.on_press(self)
  text_button.hover(self)
  text_button.pressed(self)
  return self.w
end

return main
