local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local beautiful = require("beautiful")
local sep = require("util.separators")
local font = require("util.font")
local ufont = require("utils.font")
local mat_text = require("utils.material.text")
local icons = require("config.icons")

local hdds = disks or { "home" }

-- root
local disks_root = class()

function disks_root:init(args)
  -- options
  self.fg = args.fg or M.x.on_background
  self.icon = args.icon or beautiful.widget_fs_icon or { icons.widget.disk, M.x.on_surface }
  self.title = args.title or beautiful.widget_fs_title or { "FS", M.x.on_background }
  self.mode = args.mode or 'text' -- possible values: text, arcchart, block
  self.want_layout = args.layout or beautiful.widget_cpu_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 100
  self.bar_colors = args.bar_colors or beautiful.bar_colors_disk or { M.x.primary }
  -- base widgets
  self.wicon = wibox.widget {
    ufont.icon(self.icon[1]),
    widget = require("utils.material.text")({ color = self.icon[2], lv = "medium" })
  }
  self.wtext = font.caption("")
  self.wtitle = font.h6(self.title[1], self.title[2])
  self.wbars = {} -- store all bars (one by cpu/core)
  self.widget = self:make_widget()
end

function disks_root:make_widget()
  if self.mode == "arcchart" then
    return self:make_arcchart()
  elseif self.mode == "block" then
    return self:make_block()
  else
    return self:make_text()
  end
end

function disks_root:make_all_arcchart()
  for i=1, #hdds do
    if i >= 2 then -- trick to add circle in circle in circle
      self.wbars[i] = widget.make_arcchart(self.wbars[i-1])
    else
      self.wbars[i] = widget.make_arcchart()
    end
  end
end

function disks_root:make_arcchart()
  self:make_all_arcchart()
  local w = self.wbars[#hdds]
  -- signal
  awesome.connect_signal("daemon::disks", function(fs_info)
    if fs_info ~= nil and fs_info[1] ~= nil then
      for i=1, #hdds do
        self.wbars[i].value = fs_info[i].used_percent
      end
    end
  end)
  return w
end

function disks_root:make_progressbar_vert(bars, titles)
  local w = wibox.widget {
    widget.centered(
      widget.box('vertical', { self.wtitle, titles }), "vertical"
    ),
    widget.centered(bars, "vertical"),
    spacing = 15,
    layout = wibox.layout.fixed.horizontal
  }
  return w
end

function disks_root:make_block()
  for i = 1, #hdds do
    self.wbars[i] = {}
    self.wbars[i]["title"] = font.caption(hdds[i], self.fg, M.t.medium)
    self.wbars[i]["used_percent"] = widget.make_progressbar(_, self.bar_size, self.bar_colors[i])
    self.wbars[i]["size"] = font.caption("")
  end

  local w
  if self.want_layout == 'horizontal' then
    w = wibox.widget{ layout = wibox.layout.fixed.vertical }
    for i=1, #hdds do
      local t = self.wbars[i].title -- box
      local u = self.wbars[i].used_percent -- progressbar
      local s = self.wbars[i].size -- text size
      local wx = wibox.widget {
        {
          widget.box(self.want_layout, { self.wicon, t, u, s }, 8),
          widget = widget.progressbar_margin_horiz()
        },
        layout = wibox.layout.fixed.vertical
      }
      w:add(wx)
    end
  elseif self.want_layout == 'vertical' then
    local wp = wibox.widget { layout = wibox.layout.fixed.horizontal } -- progressbar
    local wn = wibox.widget { layout = wibox.layout.fixed.horizontal } -- fs names
    for i = 1, #hdds do
      local n = font.caption(tostring(i), self.icon[2], M.t.medium)
      local t = self.wbars[i].title
      local u = widget.progressbar_layout(self.wbars[i].used_percent, self.want_layout)
      wp:add(widget.box(self.want_layout, { u }, 4))
      wn:add(widget.box('horizontal', { n, font.caption(":", self.fg, M.t.disabled), t, sep.pad(2) }))
    end
    w = self:make_progressbar_vert(wp, wn)
  end
  awesome.connect_signal("daemon::disks", function(fs_info)
    if fs_info ~= nil and fs_info[1] ~= nil then
      for i=1, #hdds do
        self.wbars[i].used_percent.value = fs_info[i].used_percent
        self.wbars[i].size.markup = helpers.colorize_text(fs_info[i].size, M.x.primary)
      end
    end
  end)
  return w
end

-- herit
local disks_widget = class(disks_root)

function disks_widget:init(args)
  disks_root.init(self, args)
  return self.widget
end

return disks_widget
