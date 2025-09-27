local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local font = require("util.font")
local ufont = require("utils.font")
local mat_text = require("utils.material.text")
local icons = require("config.icons")

-- beautiful vars
local spacing = beautiful.widget_spacing or 1

-- root
local ram_root = class()

function ram_root:init(args)
  -- options
  self.icon = args.icon or beautiful.widget_ram_icon or { icons.widget.ram, M.x.on_surface }
  self.fg = args.fg or beautiful.widget_ram_fg or M.x.on_surface
  self.title = args.title or beautiful.widget_ram_title or { "RAM", beautiful.on_background }
  self.mode = args.mode or 'text' -- possible values: text, progressbar, arcchart
  self.want_layout = args.layout or beautiful.widget_ram_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 200
  self.bar_colors = args.bar_colors or beautiful.bar_color or M.x.primary
  -- base widgets
  self.wicon = wibox.widget {
    ufont.icon(self.icon[1]),
    widget = require("utils.material.text")({ color = self.icon[2], lv = "medium" })
  }
  self.wtitle = font.h6(self.title[1], self.title[2])
  self.wtext = font.button("")
  self.widget = self:make_widget()
end

function ram_root:make_widget()
  if self.mode == "arcchart" then
    return self:make_arcchart()
  elseif self.mode == "progressbar" then
    return self:make_progressbar()
  else
    return self:make_text()
  end
end

function ram_root:make_text()
  local w = widget.box_with_margin(self.want_layout, { self.wicon, self.wtext }, spacing)
  awesome.connect_signal("daemon::ram", function(mem)
    self.wtext.markup = helpers.colorize_text(mem.inuse_percent.."%", self.fg, M.t.medium)
  end)
  return w
end

function ram_root:make_arcchart()
  local arc = widget.make_arcchart()
  local mtext = wibox.widget {
    self.wtext,
    widget = mat_text({ lv = "medium" })
  }
  arc.widget = mtext -- include text in the arc widget
  local w = arc
  awesome.connect_signal("daemon::ram", function(mem)
    arc.max_value = mem.total
    arc.values = { mem.inuse, mem.swp.inuse }
    self.wtext.text = tostring(mem.inuse_percent).."%"
  end)
  return w
end

function ram_root:make_progressbar_vert(p)
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
      widget.box('vertical', { p }),
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    spacing = 15,
    layout = wibox.layout.fixed.horizontal
  }
  return w
end

function ram_root:make_progressbar()
  local p = widget.make_progressbar(_, self.bar_size, self.bar_colors)
  local wp = widget.progressbar_layout(p, self.want_layout)
  local w
  if self.want_layout == 'vertical' then
    w = self:make_progressbar_vert(wp)
  else
    w = widget.box_with_margin(self.want_layout, { self.wicon, wp }, 8)
  end
  awesome.connect_signal("daemon::ram", function(mem)
    p.value = mem.inuse_percent
    self.wtext.markup = helpers.colorize_text(tostring(mem.total).." MB", self.fg, M.t.medium)
  end)
  return w
end

-- herit
local ram_widget = class(ram_root)

function ram_widget:init(args)
  ram_root.init(self, args)
  return self.widget
end

return ram_widget
