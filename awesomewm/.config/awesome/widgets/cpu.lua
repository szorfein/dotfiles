local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local font = require("util.font")
local ufont = require("utils.font")
local mat_text = require("utils.material.text")

-- beautiful vars
local spacing = beautiful.widget_spacing or 1

-- root
local cpu_root = class()

function cpu_root:init(args)
  -- options
  self.fg = args.fg or beautiful.widget_cpu_fg or M.x.on_background
  self.mode = args.mode or 'text' -- possible values: text, arcchart, progressbar, dotsbar
  self.want_layout = args.layout or beautiful.widget_cpu_layout or 'horizontal' -- possible values: horizontal , vertical
  self.cpus = cpu_core or 1 -- number of cpu / core
  self.title = args.title or beautiful.widget_cpu_title or { "CPU", M.x.on_background }
  self.bar_colors = args.bar_colors or beautiful.bar_color or M.x.error
  -- base widgets
  self.wicon = font.button("")
  self.wtext = font.button("")
  self.wtitle = font.h6(self.title[1], self.title[2])
  self.wbars = {} -- store all bars (one by cpu/core)
  self.wfreqs = {} -- store all freqs (one by cpu/core)
  self.widget = self:make_widget()
end

function cpu_root:make_widget()
  if self.mode == "arcchart" then
    return self:make_arcchart()
  elseif self.mode == "progressbar" then
    return self:make_progressbar()
  elseif self.mode == "dotsbar" then
    return self:make_dotsbar()
  else
    return self:make_text()
  end
end

function cpu_root:make_text()
  local w = widget.box_with_margin(self.want_layout, { self.wicon, self.wtext }, spacing)
  awesome.connect_signal("daemon::cpu", function(cpus)
    self.wicon.markup = helpers.colorize_text("x", self.fg)
    self.wtext.markup = helpers.colorize_text(cpus[1]..'%', self.fg)
  end)
  return w
end

function cpu_root:make_all_arcchart()
  for i = 1, self.cpus do
    if i >= 2 then
      self.wbars[i] = widget.make_arcchart(self.wbars[i-1])
    else
      self.wbars[i] = widget.make_arcchart()
    end
  end
end

function cpu_root:make_arcchart()
  self:make_all_arcchart()
  local mtext = wibox.widget {
    self.wtext,
    widget = mat_text({ lv = "medium" })
  }
  self.wbars[1].widget = mtext
  local w = self.wbars[self.cpus]
  awesome.connect_signal("daemon::cpu", function(cpus)
    self.wtext.text = cpus[1].."%"
    self:update_wbars(cpus)
  end)
  return w
end

function cpu_root:update_wbars(cpus)
  for i = 1, self.cpus do 
    self.wbars[i].value = tostring(cpus[i]) -- the first entry do not count as a core
  end
end

function cpu_root:make_all_progressbar()
  for i = 1, self.cpus do
    self.wbars[i] = widget.make_progressbar(_, 200)
    self.wbars[i].forced_height = 8
  end
end

function cpu_root:make_progressbar()
  self:make_all_progressbar()
  local w = widget.box('vertical', self.wbars )
  awesome.connect_signal("daemon::cpu", function(cpus)
    self:update_wbars(cpus)
  end)
  return w
end

function cpu_root:dotsbar_vert(freq)

  local t = wibox.widget {
    ufont.caption(self.cpus.." Cores"),
    widget = require("utils.material.text")({ color = M.x.on_background, lv = "medium" })
  }
  local wb = wibox.widget { layout = wibox.layout.fixed.horizontal, spacing = 4 }
  for i = 1, self.cpus do
    wb:add(widget.box_with_bg(self.want_layout, self.wbars[i], -10, M.x.surface .. "66"))
  end
  local w = wibox.widget {
    {
      widget.centered(
        widget.box('vertical', { self.wtitle, freq }), "vertical"
      ),
      wb,
      spacing = 15,
      layout = wibox.layout.fixed.horizontal
    },
    top = 8,
    bottom = 8,
    widget = wibox.container.margin
  }
  return w
end

function cpu_root:dotsbar_horiz(freq)
  local t = wibox.widget.textbox(self.cpus.." Cores")
  local y, w, z
  y = widget.box(self.want_layout, { t })
  w = wibox.widget{ layout = wibox.layout.fixed.vertical, spacing = 1 }
  z = wibox.widget{ layout = wibox.layout.fixed.vertical, spacing = 12 } -- adjust spacing, depend of the symbol used
  for i = 1, self.cpus do
    self.wfreqs[i] = font.body_text("")
    w:add(widget.box_with_bg(self.want_layout, self.wbars[i], 2, M.x.surface .. "66"))
    z:add(widget.box(self.want_layout, { self.wfreqs[i]} ))
  end
  return widget.centered(
    {
      y,
      widget.box('horizontal', { w, z }),
      layout = wibox.layout.fixed.vertical
    }, "vertical"
  )
end

function cpu_root:make_dotsbar()
  local bar = self.want_layout == 'vertical'
    and { size = 5, divisor = 18 } -- 100 / 18 = 5
    or { size = 8, divisor = 12 }

  for c = 1, self.cpus do
    self.wbars[c] = {}
    for i = 1, bar.size do
      table.insert(self.wbars[c], font.caption("", M.x.surface))
    end
  end

  local freq = font.button("")

  local w = self.want_layout == 'vertical'
    and self:dotsbar_vert(freq)
    or self:dotsbar_horiz(freq)

  awesome.connect_signal("daemon::cpu", function(cpus)
    local symbol = self.want_layout == "horizontal" and "" or ""
    freq.markup = helpers.colorize_text(cpus[1].."%", M.x.on_surface, M.t.medium)
    for c = 1, self.cpus do
      local val = math.floor(cpus[c]/bar.divisor)
      if self.want_layout == "horizontal" then
        self.wfreqs[c].markup = helpers.colorize_text(cpus[c].."%", M.x.surface)
      end
      for i = 1, bar.size do
        local color = (val >= i and self.bar_colors or M.x.surface)
        self.wbars[c][i].markup = helpers.colorize_text(symbol, color)
      end
    end
  end)
  return w
end

-- herit
local cpu_widget = class(cpu_root)

function cpu_widget:init(args)
  cpu_root.init(self, args)
  return self.widget
end

return cpu_widget
