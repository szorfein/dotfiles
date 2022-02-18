local wibox = require('wibox')
local gears = require('gears')

-- https://m3.material.io/components/floating-action-button/specs

local fab = class()

function fab:init(args)
  self.content = args.content or ''
  self.cmd = args.cmd or nil

  self.shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(12))
  end

  self.colors = wibox.widget {
    shape = self.shape,
    bg = md.sys.color.primary_container,
    fg = md.sys.color.on_primary_container,
    widget = wibox.container.background
  }

  self.states = wibox.widget {
    shape = self.shape,
    bg = md.sys.color.on_primary_container .. md.sys.elevation.level0,
    widget = wibox.container.background
  }

  self.margins = wibox.widget {
    top = dpi(20),
    bottom = dpi(20),
    left = dpi(16),
    right = dpi(16),
    widget = wibox.container.margin
  }

  self.constraint = wibox.widget {
    forced_width = dpi(56),
    forced_height = dpi(56),
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
        widget = self.states
      },
      widget = self.colors
    },
    widget = self.margins
  }
end

function fab:on_press()
  self.w:connect_signal("button::press", function()
    self.cmd()
  end)
end

function fab:hover()
  self.w:connect_signal('mouse::enter', function()
    self.states.bg = md.sys.color.on_primary_container .. md.sys.elevation.level4
  end)
  self.w:connect_signal('mouse::leave', function()
    self.states.bg = md.sys.color.on_primary_container .. md.sys.elevation.level0
  end)
end

function fab:pressed()
  self.w:connect_signal('mouse::press', function()
    self.states.bg = md.sys.color.on_primary_container .. md.sys.elevation.level3
  end)
end

local main = class(fab)

function main:init(args)
  fab.init(self, args)
  fab.on_press(self)
  fab.hover(self)
  fab.pressed(self)
  return self.w
end

return main
