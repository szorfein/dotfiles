local awful = require("awful")
local table = require("gears.table")
local wibox = require("wibox")
local beautiful = require("beautiful")
local font = require("utils.font")
local icons = require("config.icons")

local tags = beautiful.tags or { icons.app.xst, icons.app.spior, icons.app.default, icons.app.duck, icons.app.cava, icons.app.neomutt, icons.app.zathura, icons.app.scrot, icons.app.virtualbox}

local taglist_root = class()

function taglist_root:init(args)
  self.layout = args.layout or 'horizontal'
  self.template = self:select_template()
  self.buttons = self:make_buttons()
end

function taglist_root:select_template()
    return self:template_text() -- default
end

function taglist_root:make_buttons()
  local s = awful.screen.focused()
  local button = table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({}, 3, function(t)
    s.app_drawer.visible = not s.app_drawer.visible
    update_app_drawer(t.index)
  end),
  awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end)
  )
  return button
end

function taglist_root:update_text(item, tag, index)
  if tag.selected then
    item.text = tags[index]
  elseif tag.urgent then
    item.text = tags[index]
  elseif #tag:clients() > 0 then
    item.text = tags[index]
  else
    item.text = tags[index]
  end
end

-- https://material.io/components/navigation-rail#theming
function taglist_root:update_bg(item, tag, index)
  if tag.selected then
    item.fg = M.x.on_background .. "FF" -- 100%
    item.bg = M.x.on_background .. "1F" -- 12%
  elseif tag.urgent then
    item.fg = M.x.error .. "FF" -- 100%
    item.bg = M.x.on_background .. "0A" -- 4%
  elseif #tag:clients() > 0 then
    item.fg = M.x.on_background .. "B3" -- 70%
    item.bg = M.x.on_background .. "0A" -- 4%
  else
    item.fg = M.x.on_background .. "66" -- 40%
    item.bg = M.x.on_background .. "00" -- 0%
  end
end

function taglist_root:template_text() 
  local t = {
    {
      {
        id = 'text_tag',
        font = M.f.icon,
        widget = wibox.widget.textbox,
      },
      widget = wibox.container.margin
    },
    id = 'mat_background',
    widget = wibox.container.background,
    create_callback = function(item, tag, index, _)
      local textbox = item:get_children_by_id('text_tag')[1]
      self:update_text(textbox, tag, index)
      self:update_bg(item, tag, index)
    end,
    update_callback = function(item, tag, index, _)
      local textbox = item:get_children_by_id('text_tag')[1]
      self:update_text(textbox, tag, index)
      self:update_bg(item, tag, index)
    end
  }
  return t
end

local taglist_widget = class(taglist_root)

function taglist_widget:init(s, args)
  taglist_root.init(self, args)

  local w = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = self.buttons,
    style = { font = M.f.icon },
    layout = {
      spacing = dpi(7),
      layout = wibox.layout.fixed[self.layout]
    },
    widget_template = self.template
  }
  return w
end

return taglist_widget
