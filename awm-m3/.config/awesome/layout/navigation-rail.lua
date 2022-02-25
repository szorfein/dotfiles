local awful = require('awful')
local wibox = require('wibox')
local fab = require('lib.mat.fab')
local text_button = require('lib.mat.text-button')

-- https://m3.material.io/components/navigation-rail/specs
local nav_rail = class()

function nav_rail:init(args)
  self.screen = args.screen or awful.screen.focused()
  self.visible = args.visible or true
  self.menubar = args.menubar
  self.taglist = args.taglist or {}
  self.rail = wibox(self:wibox_args())
end

function nav_rail:wibox_args()
  return {
    screen = self.screen,
    ontop = true,
    type = 'dock',
    visible = self.visible,
    x = 0,
    y = 0,
    width = dpi(80),
    height = self.screen.geometry.height
  }
end

function nav_rail:screen_padding()
  if self.visible then
    self.screen.padding = { left = dpi(80) }
  else
    self.screen.padding = { left = 0 }
  end
end

function nav_rail:placement()
  awful.placement.top_left(self.rail)
  awful.placement.maximize_vertically(self.rail, { honor_workarea = true })
end

function nav_rail:setup()
  self.rail:setup {
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
        content = '',
        fg = md.sys.color.on_surface
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
    self.taglist,
    expand = 'none',
    layout = wibox.layout.align.horizontal
  }
end

local main = class(nav_rail)

function main:init(args)
  nav_rail.init(self, args)

  self:placement()
  self:screen_padding()
  self:setup()

  return self.rail
end

return main
