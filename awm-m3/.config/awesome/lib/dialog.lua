local awful = require('awful')
local wibox = require('wibox')
local table = require('gears.table')
local helpers = require('lib.helpers')

-- https://m3.material.io/components/dialogs/specs

local dialog = class()

function dialog:init()
  self.s = awful.screen.focused()
  self.w = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "splash", screen = self.s })

  self.w.bg = md.sys.color.surface_variant .. "66" -- 40%
  self.w.height = self.s.geometry.height
  self.w.width = self.s.geometry.width
  awful.placement.maximize(self.w)

  self:add_buttons()
end

-- @args title (string), widget (wibox.widget)
function dialog:centered(title, widget)
  self.w:setup {
    {
      nil,
      {
        nil,
        {
          {
            {
              self:headline(title),
              widget,
              spacing = dpi(16),
              layout = wibox.layout.fixed.vertical
            },
            margins = dpi(24),
            widget = wibox.container.margin
          },
          shape = helpers:rrect(dpi(28)),
          bg = md.sys.color.surface,
          widget = wibox.container.background
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
      },
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    margins = dpi(50),
    widget = wibox.container.margin
  }

  self.w.visible = true
end

function dialog:headline(name)
  return wibox.widget {
    nil,
    {
      {
        text = name,
        font = md.sys.typescale.headline_small.font
          .. ' ' .. md.sys.typescale.headline_small.size,
        widget = wibox.widget.textbox
      },
      fg = md.sys.color.on_surface,
      widget = wibox.container.background
    },
    expand = 'none',
    layout = wibox.layout.align.horizontal
  }
end

function dialog:add_buttons()
  self.w:buttons(table.join(
    awful.button({}, 3, function() self:hide() end)
  ))
end

function dialog:hide()
  self.w.visible = false
end

return dialog()
