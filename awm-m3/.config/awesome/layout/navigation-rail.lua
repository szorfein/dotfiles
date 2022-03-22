local awful = require('awful')
local wibox = require('wibox')
local fab = require('lib.fab')
local button_text = require('lib.button-text')

-- https://m3.material.io/components/navigation-rail/specs
local nav_rail = class()

function nav_rail:init(args)
  self.screen = args.screen or awful.screen.focused()
  self.visible = args.visible or false
  self.menubar = args.menubar
  self.screen.rail = wibox(self:wibox_args())

  self.dialog_change_theme = require('lib.dialog')({ name = 'change_theme' })
  self.dialog_change_theme:centered(
    'Change theme',
    self:change_theme()
  )

  self:setup()
  self:signals()
end

function nav_rail:wibox_args()
  return {
    screen = self.screen,
    ontop = true,
    type = 'dock',
    visible = false,
    x = 0,
    y = 0,
    width = dpi(80),
    height = self.screen.geometry.height
  }
end

function nav_rail:placement()
  awful.placement.top_left(self.screen.rail)
  awful.placement.maximize_vertically(self.screen.rail)
end

function nav_rail:setup()
  self.screen.rail:setup {
    {
      self:top_widget(),
      self:middle_widget(),
      self:bottom_widget(),
      expand = 'none',
      layout = wibox.layout.align.vertical
    },
    bottom = dpi(16),
    widget = wibox.container.margin
  }
end

function nav_rail:top_widget()
  return wibox.widget {
    {
      button_text({
        icon = '󰍜',
        fg = md.sys.color.on_surface_variant,
        cmd = function() self:hide() end
      }).widget,
      left = dpi(16), top = dpi(10), right = dpi(16),
      widget = wibox.container.margin
    },
    {
      fab({
        icon = '',
        cmd = self.menubar.show,
      }),
      left = dpi(16), right = dpi(16),
      widget = wibox.container.margin
    },
    spacing = dpi(16),
    layout = wibox.layout.fixed.vertical
  }
end

function nav_rail:middle_widget()
  return wibox.widget {
    nil,
    require('mod.taglist')({ screen = self.screen }),
    expand = 'none',
    layout = wibox.layout.align.horizontal
  }
end

function nav_rail:bottom_widget()
  return wibox.widget {
    nil,
    button_text({
      icon = '󰌁',
      cmd = function() self.dialog_change_theme:display() end
    }).widget,
    expand = 'none',
    layout = wibox.layout.align.horizontal
  }
end

function nav_rail:show()
  local right_pad = 0
  if self.screen.panel then
    right_pad = self.screen.panel.visible and dpi(256) or 0
  end
  self.screen.padding = { left = dpi(80), right = right_pad }
  self:placement()
  self.screen.rail.visible = true
end

function nav_rail:hide()
  local right_pad = 0
  if self.screen.panel then
    right_pad = self.screen.panel.visible and dpi(256) or 0
  end
  self.screen.padding = { left = 0, right = right_pad }
  self.screen.rail.visible = false
end

function nav_rail:signals()
  self.screen.rail_activator = wibox({y = 0, width = 1, visible = true, ontop = false, opacity = 0, below = true, screen = self.screen})

  self.screen.rail_activator.height = self.screen.geometry.height
  awful.placement.left(self.screen.rail_activator)

  self.screen.rail_activator:connect_signal('mouse::enter', function()
    self:show()
  end)
end

function nav_rail:change_theme()
  return wibox.widget {
    {
      text = 'BETA',
      widget = wibox.widget.textbox
    },
    {
      text = 'LINES',
      widget = wibox.widget.textbox
    },
    layout = wibox.layout.fixed.horizontal
  }
end

local main = class(nav_rail)

function main:init(args)
  nav_rail.init(self, args)

  if self.visible then
    self:show()
  end
end

return main
