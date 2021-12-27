local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local aspawn = require("awful.spawn")
local font = require("util.font")
local ufont = require("utils.font")
local icons = require("config.icons")

-- beautiful vars
local spacing = beautiful.widget_spacing or 1

-- root
local volume_root = class()

function volume_root:init(args)
  -- options
  self.fg = args.fg or beautiful.widget_volume_fg or M.x.on_surface
  self.bg = args.bg or beautiful.widget_volume_bg or M.x.surface
  self.icon = args.icon or beautiful.widget_volume_icon or { icons.widget.vol, M.x.on_surface }
  self.mode = args.mode or 'text' -- possible values: text, progressbar, slider
  self.layout = args.layout or beautiful.widget_volume_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 200
  self.bar_colors = args.bar_colors or beautiful.bar_color or M.x.primary
  self.title = args.title or beautiful.widget_volume_title or { "VOL", M.x.on_background }
  self.title_size = args.title_size or 10
  -- base widgets
  self.wicon = wibox.widget {
    ufont.icon(self.icon[1]),
    widget = require("utils.material.text")({ color = self.icon[2], lv = "medium" })
  }
  self.wtitle = font.h6(self.title[1], self.title[2])
  self.wtext = font.button("")
  self.background = wibox.widget {
    bg = self.bg,
    widget = wibox.container.background
  }
  self.w = self:make_widget()
end

function volume_root:make_widget()
  if self.mode == "progressbar" then
    return self:make_progressbar()
  elseif self.mode == "slider" then
    return self:make_slider()
  else
    return self:make_text()
  end
end

function volume_root:update(volume, fg, bg)
  self.wtext.markup = helpers.colorize_text(volume.."%", fg, M.t.medium)
  self.background.bg = bg
end

function volume_root:make_text()
  local w = wibox.widget {
    {
      self.wicon, self.wtext,
      spacing = spacing,
      layout = wibox.layout.fixed[self.layout],
    },
    widget = self.background
  }
  awesome.connect_signal("daemon::volume", function(volume, is_muted)
      if is_muted == 1 then
        self:update(volume, M.x.on_error, M.x.error)
      else
        self:update(volume, self.fg, self.bg)
      end
  end)
  return w
end

function volume_root:make_slider()
  --local volume = widget.make_a_slider(15, self.bar_colors)
  local mat_slider = require("util.slider")({ color = M.x.secondary })
  local volume = wibox.widget { read_only = false, widget = mat_slider }
  local w = widget.box(self.layout, { self.wicon, volume }, 8)
  w.forced_height = 48
  -- Set value
  volume:connect_signal('property::value', function()
    aspawn.with_shell('~/bin/volume.sh set ' .. volume.value)
  end)
  -- get volume
  awesome.connect_signal("daemon::volume", function(vol, is_muted)
    if not (vol == nil) then
      volume:set_value(vol)
    else
      volume:set_value(0)
    end
  end)
  return w
end

function volume_root:make_progressbar_vert(p)
  local w = wibox.widget {
    {
      nil,
      {
        self.wtitle,
        {
          self.wicon,
          self.wtext,
          spacing = dpi(4),
          layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.fixed.vertical
      },
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    {
      nil,
      widget.box('horizontal', { p }),
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    spacing = 15,
    layout = wibox.layout.fixed.horizontal
  }
  return w
end

function volume_root:make_progressbar()
  local p = widget.make_progressbar(_, self.bar_size, self.bar_colors)
  local wp = widget.progressbar_layout(p, self.layout)
  local w
  if self.layout == 'vertical' then
    w = self:make_progressbar_vert(wp)
  else
    w = widget.box_with_margin(self.layout, { self.wicon, wp }, 8)
  end
  awesome.connect_signal("daemon::volume", function(vol, is_muted)
    p.value = vol
    self.wtext.markup = helpers.colorize_text(vol.."%", self.fg, M.t.medium)
  end)
  return w
end

-- herit
local volume_widget = class(volume_root)

function volume_widget:init(args)
  volume_root.init(self, args)
  return self.w
end

return volume_widget
