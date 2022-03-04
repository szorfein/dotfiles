local awful = require('awful')
local wibox = require('wibox')
local fab = require('lib.mat.fab')
local text_button = require('lib.button-text')

-- https://m3.material.io/components/navigation-rail/specs
local nav_rail = class()

function nav_rail:init(args)
  self.screen = args.screen or awful.screen.focused()
  self.visible = args.visible or false
  self.menubar = args.menubar
  self.screen.rail = wibox(self:wibox_args())
  self:setup()
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
    self:top_widget(),
    self:middle_widget(),
    expand = 'none',
    layout = wibox.layout.align.vertical
  }
end

function nav_rail:top_widget()
  return wibox.widget {
    {
      text_button({
        icon = '',
        fg = md.sys.color.on_surface,
        cmd = function() self:hide() end
      }),
      left = dpi(14), right = dpi(14),
      widget = wibox.container.margin
    },
    fab({
      content = '',
      cmd = self.menubar.show,
    }),
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

function nav_rail:show()
  self.screen.padding = { left = dpi(80) }
  self:placement()
  self.screen.rail.visible = true
end

function nav_rail:hide()
  self.screen.padding = { left = 0 }
  self.screen.rail.visible = false
end

local main = class(nav_rail)

function main:init(args)
  nav_rail.init(self, args)

  if self.visible then
    self:show()
  end
end

return main
