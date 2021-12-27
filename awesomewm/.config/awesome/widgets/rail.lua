local gtable = require("gears.table")
local awful = require("awful")
local mat_bg = require("utils.material.background")
local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = require("helpers")

local rail = class()

function rail:init(s)
  self.s = s or awful.screen.focused()
  self.ntags = beautiful.ntags or 10
  self.i_focused = beautiful.taglist_icons_focused
  self.i_urgent = beautiful.taglist_icons_urgent
  self.i_occupied = beautiful.taglist_icons_occupied
  self.i_empty = beautiful.taglist_icons_empty
  self.colorline_enable = M.x.secondary
  self.wtags = {}
  self.wicons = {}
  self.wlines = {}
  self.wbg_focus = {}
  self.w = wibox.widget { layout = wibox.layout.fixed.vertical }

  self:build_taglist()
  self:signals()

  return wibox.widget { self.w, layout = wibox.layout.fixed.vertical }
end

function rail:build_taglist()
  for i = 1, self.ntags do
    self:build_icon(i)
    self.wlines[i] = wibox.widget {
      left = 2,
      color = M.x.background,
      widget = wibox.container.margin
    }
    self.wbg_focus[i] = wibox.widget {
      bg = M.x.surface,
      shape = helpers.rrect(10),
      widget = wibox.container.background
    }
    self.wtags[i] = wibox.widget {
      {
        {
          {
            nil,
            {
              nil,
              {
                self.wicons[i],
                margins = dpi(8),
                widget = wibox.container.margin
              },
              expand = "none",
              layout = wibox.layout.align.horizontal
            },
            expand = "none",
            layout = wibox.layout.align.vertical
          },
          widget = mat_bg({ color = M.x.on_background })
        },
        widget = self.wlines[i]
      },
      widget = self.wbg_focus[i],
    }
    self:buttons(i)
    self.w:add(self.wtags[i])
  end
end

function rail:enable(index)
  local index = index or 1
    -- clear previous line,
    -- only one element should be active
    for k,v in pairs(self.wlines) do
      self.wlines[k].color = M.x.background -- remove old enable line
      self.wbg_focus[k].bg = M.x.background
    end
    self.wlines[index].color = self.colorline_enable
    self.wbg_focus[index].bg = M.x.on_background .. "1F" -- 12%
end

function rail:build_icon(index)
  self.wicons[index] = wibox.widget {
    forced_height = 28,
    forced_width = 28,
    widget = wibox.widget.imagebox
  }
end

function rail:buttons(index)
  self.wtags[index]:buttons(gtable.join(
    awful.button({}, 1, function()
      local current_tag = self.s.selected_tag
      local clicked_tag = self.s.tags[index]
      if clicked_tag == current_tag then
        awful.tag.history.restore()
      else
        clicked_tag:view_only()
      end
    end),
    awful.button({}, 3, function()
      self.s.app_drawer.visible = not self.s.app_drawer.visible
      update_app_drawer(index)
    end),
    awful.button({}, 4, function()
      awful.tag.viewprev()
    end),
    awful.button({}, 5, function()
      awful.tag.viewnext()
    end)
  ))
end

function rail:update()
  for i = 1, self.ntags do
    local tag_clients
    if self.s.tags[i] then
      tag_clients = self.s.tags[i]:clients()
    end
    if self.s.tags[i] and self.s.tags[i].selected then
      self.wicons[i].image = self.i_focused[i]
      self:enable(i)
    elseif self.s.tags[i] and self.s.tags[i].urgent then
      self.wicons[i].image = self.i_urgent[i]
    elseif tag_clients and #tag_clients > 0 then
      self.wicons[i].image = self.i_occupied[i]
    else
      self.wicons[i].image = self.i_empty[i]
    end
  end
end

function rail:signals()
  client.connect_signal("unmanage", function(c) self:update() end)
  client.connect_signal("untagged", function(c) self:update() end)
  client.connect_signal("tagged", function(c) self:update() end)
  client.connect_signal("screen", function(c) self:update() end)
  awful.tag.attached_connect_signal(self.s, "property::selected", function()
    self:update()
  end)
  awful.tag.attached_connect_signal(self.s, "property::hide", function()
    self:update()
  end)
  awful.tag.attached_connect_signal(self.s, "property::activated", function()
    self:update()
  end)
  awful.tag.attached_connect_signal(self.s, "property::screen", function()
    self:update()
  end)
  awful.tag.attached_connect_signal(self.s, "property::index", function()
    self:update()
  end)
  awful.tag.attached_connect_signal(self.s, "property::urgent", function()
    self:update()
  end)
end

return rail
