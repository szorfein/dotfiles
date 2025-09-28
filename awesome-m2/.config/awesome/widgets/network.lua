local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local font = require("util.font")
local ufont = require("utils.font")
local icons = require("config.icons")

local net_dev = network or "lo"

-- beautiful vars
local spacing = beautiful.widget_spacing or 1

-- root
local network_root = class()

function network_root:init(args)
  -- options
  self.fg = args.fg or beautiful.widget_network_fg or M.x.on_surface
  --self.bg = args.bg or beautiful.widget_network_bg or M.x.surface
  self.icon = args.icon or beautiful.widget_network_icon or { icons.widget.net, M.x.on_surface }
  self.icon_ip = args.icon_ip or beautiful.widget_network_icon_ip or { icons.widget.ip, M.x.on_background }
  self.title = args.title or beautiful.widget_network_title or { "NET", M.x.on_background }
  self.mode = args.mode or 'text' -- possible values: ip, text
  self.want_layout = args.layout or beautiful.widget_network_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 100
  self.bar_colors = args.bar_colors or beautiful.bar_colors_network or { M.x.primary, M.x.primary }
  -- base widgets
  self.wicon = wibox.widget {
    ufont.icon(self.icon[1]),
    widget = require("utils.material.text")({ color = self.icon[2], lv = "medium" })
  }
  self.wicon_net = wibox.widget {
    ufont.icon(self.icon_ip[1]),
    widget = require("utils.material.text")({ color = self.icon_ip[2], lv = "medium" })
  }
  self.wtext = font.button("")
  self.wtext_1 = font.button("")
  self.wtext_2 = font.button("")
  self.wtitle = font.h6(self.title[1], self.title[2])
  self.widget = self:make_widget()
end

function network_root:make_widget()
  if self.mode == "ip" then
    return self:make_ip()
  elseif self.mode == "block" then
    return self:make_block()
  else
    return self:make_text()
  end
end

function network_root:make_ip()
  local w = widget.box_with_margin(self.want_layout, { self.wicon_net, self.wtext_1 }, spacing)
  awesome.connect_signal("daemon::network", function(net)
    self.wtext_1.markup = helpers.colorize_text(net[net_dev].name.." "..net[net_dev].ip, self.fg)
  end)
  return w
end

function network_root:make_text()
  local w = widget.box_with_margin(self.want_layout, { self.wicon, self.wtext_1, self.wtext_2 }, spacing)
  awesome.connect_signal("daemon::network", function(net)
    self.wtext_1.markup = helpers.colorize_text(net[net_dev].up, self.fg)
    self.wtext_2.markup = helpers.colorize_text(net[net_dev].down, self.fg)
  end)
  return w
end

function network_root:make_progressbar_vert(p_up, p_down)
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
      widget.box('horizontal', { p_up, p_down }, 2),
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    spacing = 15,
    layout = wibox.layout.fixed.horizontal
  }
  return w
end

function network_root:make_block()
  local pu = widget.make_progressbar(_, self.bar_size, self.bar_colors[1])
  pu.max_value = 80000
  local pd = widget.make_progressbar(_, self.bar_size, self.bar_colors[2])
  pd.max_value = 80000
  local w
  local ip = ufont.caption("")
  if self.want_layout == 'horizontal' then
    local space = 8
    w = wibox.widget {
      {
        widget.box(self.want_layout, { self.wicon_net, ip }, space),
        widget = widget.progressbar_margin_horiz()
      },
      {
        {
          nil,
          self.wicon,
          nil,
          expand = "none",
          layout = wibox.layout.align.vertical
        },
        {
          {
            pu,
            widget = widget.progressbar_margin_horiz()
          },
          {
            pd,
            widget = widget.progressbar_margin_horiz()
          },
          layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.fixed.horizontal
      },
      layout = wibox.layout.fixed.vertical
    }
  elseif self.want_layout == 'vertical' then
    local p_up = widget.progressbar_layout(pu, self.want_layout)
    local p_down = widget.progressbar_layout(pd, self.want_layout)
    w = self:make_progressbar_vert(p_up, p_down)
  end
  awesome.connect_signal("daemon::network", function(net)
    local up = net[net_dev].up
    local down = net[net_dev].down
    pu.value = up
    pd.value = down
    ip.markup = helpers.colorize_text(net[net_dev].ip, self.fg, M.t.medium)
    self.wtext_1.markup = helpers.colorize_text(up.." B/s", self.fg)
    self.wtext_2.markup = helpers.colorize_text(down.." B/s", self.fg)
    self.wtext.markup = helpers.colorize_text(net_dev, self.fg, M.t.medium)
  end)
  return w
end

-- herit
local network_widget = class(network_root)

function network_widget:init(args)
  network_root.init(self, args)
  return self.widget
end

return network_widget
