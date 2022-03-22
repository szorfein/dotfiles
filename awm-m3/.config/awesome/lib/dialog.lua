local awful = require('awful')
local table = require('gears.table')
local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/components/dialogs/specs
local dialog = class()

-- @args (table), can contain { name = 'something', s = awful.screen }
function dialog:init(args)
  self.args = args or {}
  self.name = self.args.name or 'dialog'
  self.s = self.args.s or awful.screen.focused()
  self.s[self.name] = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "splash", screen = self.s })

  self.s[self.name].bg = md.sys.color.surface_variant .. "66" -- 40%
  self.s[self.name].height = self.s.geometry.height
  self.s[self.name].width = self.s.geometry.width
  awful.placement.maximize(self.s[self.name])

  self:add_buttons()
end

-- @args title (string), widget (wibox.widget)
function dialog:centered(title, widget)
  self.s[self.name]:setup {
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
  self.s[self.name]:buttons(table.join(
    awful.button({}, 3, function() self:hide() end)
  ))
end

-- Add custom buttons
-- @arg gtable: gears.table.join
function dialog:set_buttons(gtable)
  self.s[self.name]:buttons(gtable)
end

function dialog:display()
  self.s[self.name].visible = true
end

function dialog:hide()
  self.s[self.name].visible = false
end

return dialog
