local awful = require("awful")
local wibox = require("wibox")
local table = require("gears.table")
local font = require("utils.font")
local tooltip = require("utils.tooltip")
local icons = require("config.icons")

local layoutbox_root = class()

function layoutbox_root:init(s)
  self.s = s
  self.icon = font.icon(icons.widget.float) -- default float
  self.current_mode = "floating" -- default float
  self.color = M.x.secondary_variant_2
  self.background = wibox.widget {
    fg = self.color,
    bg = self.color .. "0A",
    widget = wibox.container.background
  }
  self.w = wibox.widget {
    {
      self.icon,
      margins = 4,
      widget = wibox.container.margin
    },
    widget = self.background
  }
  self.tt = tooltip.create(self.w)
  self:buttons()
  self:signals()
end

function layoutbox_root:buttons()
  self.w:buttons(table.join(
    awful.button({}, 1, function() awful.layout.inc( 1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc( 1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)
  ))
end

function layoutbox_root:update_background(color)
  self.background.fg = color
  self.background.bg = color .. "0A" -- 4%
end

function layoutbox_root:updates()
  local curr_layout = awful.layout.get(mouse.screen)

  if curr_layout == awful.layout.suit.floating then
    self.icon.text = icons.widget.float
    self.current_mode = "floating"
    self:update_background(M.x.secondary_variant_2)
  elseif curr_layout == awful.layout.suit.tile 
    or curr_layout == awful.layout.suit.tile.left 
    or curr_layout == awful.layout.suit.tile.bottom 
    or curr_layout == awful.layout.suit.tile.top then
    self.icon.text = icons.widget.tile
    self.current_mode = "tile"
    self:update_background(M.x.primary)
  elseif curr_layout == awful.layout.suit.fair 
    or curr_layout == awful.layout.suit.fair.horizontal then
    self.icon.text = ""
    self.current_mode = "fair"
    self:update_background(M.x.primary_variant_1)
  elseif curr_layout == awful.layout.suit.max then
    self.icon.text = icons.widget.max
    self.current_mode = "max"
    self:update_background(M.x.primary_variant_2)
  else
    self.icon.text = ""
    self.current_mode = "other"
    self:update_background(M.x.error)
  end
end

function layoutbox_root:signals()
  awful.tag.attached_connect_signal(self.s, "property::selected", function()
    self:updates()
  end)
  awful.tag.attached_connect_signal(self.s, "property::layout", function()
    self:updates()
  end)
  -- tooltip
  self.w:connect_signal('mouse::enter', function()
    self.tt.text = self.current_mode
  end)
end

local layoutbox_widget = class(layoutbox_root)

function layoutbox_widget:init(s)
  layoutbox_root.init(self, s)
  return self.w
end

return layoutbox_widget
