local wibox = require("wibox")
local awful = require("awful")
local screen = require("awful.screen")
local table = require("gears.table")
local keygrabber = require("awful.keygrabber")
local font = require("utils.font")
local button = require("utils.button")
local spawn = require("awful.spawn")
local helper = require("utils.helper")
local app = require("utils.app")
local icons = require("config.icons")

local w = wibox.widget { layout = wibox.layout.fixed.vertical }

function settings_toggle()
  local s = screen.focused()
  if s.settings.visible then
    settings_hide()
  else
    s.settings.visible = true
  end
end

function settings_hide()
  local s = screen.focused()
  s.settings.visible = false
end

-- work only on a tile layout
local function screen_padding(nb)
  local s = screen.focused()
  local v = s.padding.top + nb
  s.padding = { top = v, right = v, bottom = v, left = v }
end

local padding = wibox.widget {
  nil,
  {
    button({
      fg_icon = M.x.on_surface,
      icon = font.icon(icons.misc.minus),
      command = function() screen_padding(-10) end,
    }),
    button({
      fg_icon = M.x.on_surface,
      icon = font.icon(icons.misc.plus),
      command = function() screen_padding(10) end,
    }),
    layout = wibox.layout.fixed.horizontal
  },
  expand = "none",
  layout = wibox.layout.align.horizontal
}

local gapping = wibox.widget {
  nil,
  {
    button({
      fg_icon = M.x.on_surface,
      icon = font.icon(icons.misc.minus),
      command = function() awful.tag.incgap(-2, nil) end,
    }),
    button({
      fg_icon = M.x.on_surface,
      icon = font.icon(icons.misc.plus),
      command = function() awful.tag.incgap(2, nil) end,
    }),
    layout = wibox.layout.fixed.horizontal
  },
  expand = "none",
  layout = wibox.layout.align.horizontal
}

local box = function(w)
  return wibox.widget {
    {
      w,
      margins = dpi(8),
      widget = wibox.container.margin
    },
    bg = M.x.on_surface .. "05", -- 2%
    shape = helper.rrect(4),
    widget = wibox.container.background
  }
end

local header = wibox.widget {
  nil,
  nil,
  button({
    icon = font.body_2(""),
    command = function() settings_hide() end
  }),
  expand = "none",
  layout = wibox.layout.align.horizontal
}

local myapps = class()

function myapps:init(s)
  self.height = s.geometry.height
  self.width = s.geometry.width

  s.settings = awful.wibar({ visible = false, width = dpi(230), position = "right", screen = s })
  s.settings.bg = M.x.surface
  s.settings.x = self.width - dpi(230)
  s.settings.y = 0
  s.settings.height = self.height
  s.settings.shape = helper.rrect(50)

  s.settings:buttons(table.join(
    -- Middle click - Hide settings
    awful.button({}, 2, function()
      settings_hide()
    end),
    -- Right click - Hide settings
    awful.button({}, 3, function()
      settings_hide()
    end)
  ))

  s.settings:setup {
    {
      header,
      {
      nil,
      {
        font.subtile_1("Pads, Gaps"),
        box({
          nil,
          {
            padding,
            gapping,
            layout = wibox.layout.fixed.horizontal
          },
          expand = "none",
          layout = wibox.layout.align.horizontal
        }),
        font.subtile_1("Others"),
        box({
          require("widgets.volume")({ mode = "slider" }),
          require("widgets.brightness")({ mode = "slider" }),
          layout = wibox.layout.fixed.vertical
        }),
        layout = wibox.layout.fixed.vertical

      },
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    layout = wibox.layout.fixed.vertical
    },
    margins = 10,
    widget = wibox.container.margin
  }
end

return myapps
