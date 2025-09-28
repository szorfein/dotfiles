local awful = require('awful')
local table = require('gears.table')
local wibox = require('wibox')
local helpers = require('lib.helpers')

-- https://m3.material.io/components/dialogs/specs
-- Basic dialogs

local dialog = class()

-- @args (table), can contain { name = 'something', s = awful.screen }
function dialog:init(args)
  self.args = args or {}
  self.name = self.args.name or 'dialog'
  self.title = args.title or nil
  self.widget = args.widget or nil
  self.s = self.args.s or awful.screen.focused()
  self:create_the_box()
  self:add_buttons()
end

function dialog:create_the_box()
  self.s[self.name] = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "splash", screen = self.s })

  -- scrim, m3 make a scrim with an opacity of 32% (52 in hexa)
  self.s[self.name].bg = md.sys.color.scrim .. '52'

  self.s[self.name].height = self.s.geometry.height
  self.s[self.name].width = self.s.geometry.width

  awful.placement.maximize(self.s[self.name])
end

function dialog:centered()
  self.s[self.name]:setup {
    {
      nil,
      {
        nil,
        {
          {
            {
              {
                self:headline(),
                self.widget,
                spacing = dpi(16),
                layout = wibox.layout.fixed.vertical
              },
              margins = dpi(24),
              widget = wibox.container.margin
            },
            widget = self:container_elevation()
          },
          widget = self:container()
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

function dialog:just_centered()
  self.s[self.name]:setup {
    nil,
    {
      nil,
      self.widget,
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    expand = "none",
    layout = wibox.layout.align.vertical
  }
end

function dialog:container_elevation()
  return wibox.widget {
    bg = md.sys.color.surface_tint_color .. md.sys.elevation.level1,
    shape = helpers:rrect(dpi(28)),
    widget = wibox.container.background
  }
end

function dialog:container()
  return wibox.widget {
    bg = md.sys.color.surface,
    shape = helpers:rrect(dpi(28)),
    widget = wibox.container.background
  }
end

function dialog:headline()
  if not self.title then return nil end

  return wibox.widget {
    nil,
    {
      {
        text = self.title,
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
    awful.button({}, 2, function() self:hide() end), -- middle mouse
    awful.button({}, 3, function() self:hide() end) -- right mouse
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
