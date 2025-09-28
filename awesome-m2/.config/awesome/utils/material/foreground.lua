local wibox = require("wibox")

local root_fg = class()

function root_fg:init(args)
  self.color = args.color or M.x.on_surface
  self.focus = args.focus or self.color
  self.w = wibox.widget {
    fg = self.color .. "B3", -- 70%
    widget = wibox.container.background
  }
end

-- opacity state
-- https://material.io/design/color/dark-theme.html#states
function root_fg:signals()
  self.w:connect_signal("mouse::enter", function()
    self.w.fg = self.focus .. "FF" -- 100%
  end)
  self.w:connect_signal("mouse::leave", function()
    self.w.fg = self.color .. "B3" -- 70%
  end)
  self.w:connect_signal("button::press", function()
    self.w.fg = self.focus .. "FF" -- 100%
  end)
  self.w:connect_signal("button::release", function()
    self.w.fg = self.color .. "B3" -- 70%
  end)
end

local mat_fg = class(root_fg)

function mat_fg:init(args)
  root_fg.init(self, args)
  root_fg.signals(self)
  return self.w
end

return mat_fg
