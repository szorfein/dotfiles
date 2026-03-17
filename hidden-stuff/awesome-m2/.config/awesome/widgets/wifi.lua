local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local font = require("utils.font")
local mat_text = require("utils.material.text")
local icons = require("config.icons")

local wifi_root = class()

function wifi_root:init(args)
  self.icon = args.icon or beautiful.wifi_icon or { icons.widget.wifi, M.x.on_surface }
  self.mode = args.mode or 'progressbar'
  self.bar_size = args.bar_size or 200
  self.bar_color = args.bar_color or beautiful.bar_color or M.x.primary
  self.layout = args.layout or 'horizontal'

  self:init_base_widget()
  self.widget = self:make_widget()
end

function wifi_root:init_base_widget()
  self.wicon = wibox.widget {
    font.icon(self.icon[1]),
    widget = require("utils.material.text")({ color = self.icon[2], lv = "medium" })
  }
end

function wifi_root:make_widget()
  if self.mode == "progressbar" then
    return self:progressbar()
  else
    return wibox.widget{ layout = wibox.layout.fixed[self.layout] }
  end
end

function wifi_root:progressbar()
  local p = widget.make_progressbar(_, self.bar_size, self.bar_color)
  local wp = widget.progressbar_layout(p, self.layout)
  awesome.connect_signal("daemon::wifi", function(wifi)
    p.value = wifi.str
  end)

  return widget.box_with_margin(self.layout, { self.wicon, wp }, 8)
end

local wifi_widget = class(wifi_root)

function wifi_widget:init(args)
  wifi_root.init(self, args)
  return self.widget
end

return wifi_widget
