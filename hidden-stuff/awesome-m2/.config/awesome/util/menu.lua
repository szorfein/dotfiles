local wibox = require("wibox")
local awful = require("awful")
local gtable = require("gears.table")
local font = require("util.font")
local mat_bg = require("utils.material.background")

local root_menu = class()

function root_menu:init(args)
  self.fg = args.fg or M.x.on_surface
  self.bg = args.bg or M.x.on_surface .. M.e.dp06
  self.elements = args.elements or {}
end

-- doc: https://material.io/components/menus/#specs
function root_menu:gen_menu()
  self.w = wibox.widget { layout = wibox.layout.fixed.vertical }
  for k,v in pairs(self.elements) do
    local icon = font.button(v[1], self.fg, M.t.high)
    local text = font.body_title(v[2], self.fg, M.t.high)
    local shortcut = font.body_text(v[3], self.fg, M.t.disabled)
    local w = wibox.widget {
      {
        {
          {
            {
              { -- align on the left
                icon,
                text,
                spacing = 20,
                layout = wibox.layout.fixed.horizontal
              },
              nil, -- nothing to the center
              shortcut, -- at right
              expand = "none",
              layout = wibox.layout.align.horizontal
            },
            forced_height = 48,
            forced_width = 280,
            layout = wibox.layout.flex.horizontal
          },
          left = 24, right = 24, top = 8, bottom = 8,
          widget = wibox.container.margin,
        },
        widget = mat_bg({ color = self.fg }),
      },
      bg = self.bg,
      widget = wibox.container.background
    }
    w:buttons(gtable.join(
      awful.button({}, 1, v[4])
    ))
    self.w:add(w)
  end
end

local mat_menu = class(root_menu)

function mat_menu:init(args)
  root_menu.init(self, args)
  root_menu.gen_menu(self)
  return self.w
end

return mat_menu
