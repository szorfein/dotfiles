local awful = require("awful")
local gtable = require("gears.table")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local gears = require("gears")
local widget = require("util.widgets")

local modkey = "Mod4"

-- root
local taglist_root = class()

function taglist_root:init(args)
  self.bg = beautiful.taglist_bg or M.x.on_background .. "00"
  self.bg_focus = beautiful.taglist_bg_focus or M.x.on_background .. "0A" -- 4%
  self.mode = args.mode or 'line' -- possible values: icon , line , shape , text
  self.layout = args.layout or 'horizontal' -- possible values: grid , horizontal , vertical, flex (horiz)
  self.template = self:select_template()
  self.buttons = self:make_buttons()
  self.layout = self:select_layout()
end

function taglist_root:select_layout()
  if self.layout == 'vertical' then
    return wibox.layout.fixed.vertical
  elseif self.layout == 'grid' then
    return { spacing = 10, expand = true, forced_num_rows = 2, forced_num_cols = 5, layout = wibox.layout.grid }
  elseif self.layout == 'flex' then
    return wibox.layout.flex.horizontal
  elseif self.layout == 'none' then
    return nil
  else
    return wibox.layout.fixed.horizontal -- default
  end
end

function taglist_root:select_template()
  if self.mode == 'line' then
    return self:template_line()
  elseif self.mode == 'shape' then
    return self:template_shape()
  elseif self.mode == 'icon' then
    return self:template_icon()
  else
    return self:template_text() -- default
  end
end

function taglist_root:make_buttons()
  local s = awful.screen.focused()
  local button = gtable.join(
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

function taglist_root:update_line(item, tag, index)
  if tag.selected then
    item.bg = beautiful.taglist_text_color_focused[index]
  elseif tag.urgent then
    item.bg = beautiful.taglist_text_color_urgent[index]
  elseif #tag:clients() > 0 then
    item.bg = beautiful.taglist_text_color_occupied[index]
  else
    item.bg = beautiful.taglist_text_color_empty[index]
  end
end

function taglist_root:template_line() 
  local t = {
    {
      id = 'background_role',
      widget = wibox.container.background,
    },
    bg = M.x.background,
    widget = wibox.container.background,
    create_callback = function(item, tag, index, _)
      self:update_line(item, tag, index)
    end,
    update_callback = function(item, tag, index, _)
      self:update_line(item, tag, index)
    end
  }
  return t
end

function taglist_root:update_text(item, tag, index)
  if tag.selected then
    item.markup = helpers.colorize_text(beautiful.taglist_text_focused[index], beautiful.taglist_text_color_focused[index])
  elseif tag.urgent then
    item.markup = helpers.colorize_text(beautiful.taglist_text_urgent[index], beautiful.taglist_text_color_urgent[index], M.t.high)
  elseif #tag:clients() > 0 then
    item.markup = helpers.colorize_text(beautiful.taglist_text_occupied[index], beautiful.taglist_text_color_occupied[index], M.t.medium)
  else
    item.markup = helpers.colorize_text(beautiful.taglist_text_empty[index], beautiful.taglist_text_color_empty[index], M.t.disabled)
  end
end

function taglist_root:template_text() 
  local t = {
    {
      --id = 'text_role',
      --id     = 'index_role',
      widget = wibox.widget.textbox,
    },
    id = "text_margin_role",
    margins = 6,
    widget = wibox.container.margin,
    create_callback = function(item, tag, index, _)
      local w = item:get_children()[1]
      w.align = "center"
      w.valign = "center"
      w.forced_width = dpi(25)
      w.font = M.f.button,
      self:update_text(w, tag, index)
    end,
    update_callback = function(item, tag, index, _)
      local w = item:get_children()[1]
      self:update_text(w, tag, index)
    end
  }
  return t
end

function taglist_root:update_shape(item, tag, index)
  if tag.selected then
    item.shape_border_color = beautiful.taglist_text_color_focused[index]
  elseif tag.urgent then
    item.shape_border_color = beautiful.taglist_text_color_urgent[index]
  elseif #tag:clients() > 0 then
    item.shape_border_color = beautiful.taglist_text_color_occupied[index]
  else
    item.shape_border_color = beautiful.taglist_text_color_empty[index]
  end
end

function taglist_root:template_shape() 
  local t = {
    {
      id = "text_taglist",
      widget = wibox.widget.textbox,
    },
    widget = wibox.container.background,
    create_callback = function(item, tag, index, _)
      item.shape_clip = true
      item.shape = gears.shape.circle
      item.spacing = 4
      item.shape_border_width = 2
      item.text_taglist.align = "center"
      item.text_taglist.valign = "center"
      item.text_taglist.forced_width = dpi(25)
      item.text_taglist.font = M.f.h6
      self:update_text(item.text_taglist, tag, index)
      self:update_shape(item, tag, index)
    end,
    update_callback = function(item, tag, index, _)
      self:update_text(item.text_taglist, tag, index)
      self:update_shape(item, tag, index)
    end
  }
  return t
end

function taglist_root:update_icon(item, tag, index)
  if tag.selected then
    item.image = beautiful.taglist_icons_focused[index]
  elseif tag.urgent then
    item.image = beautiful.taglist_icons_urgent[index]
  elseif #tag:clients() > 0 then
    item.image = beautiful.taglist_icons_occupied[index]
  else
    item.image = beautiful.taglist_icons_empty[index]
  end
end

function taglist_root:template_icon() 
  local function update_bg(w)
    w:connect_signal("mouse::leave", function(c)
      w.bg = self.bg
    end)
    w:connect_signal("mouse::enter", function(c)
      w.bg = self.bg_focus
    end)
  end
  local t = {
    {
      nil,
      {
        nil,
        {
          {
            id = "img_tag",
            widget = wibox.widget.imagebox,
          },
          margins = dpi(12),
          widget = wibox.container.margin
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
      },
      nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    id = "img_tag_bg",
    shape = beautiful.taglist_shape or helpers.rrect(10),
    bg = self.bg,
    widget = wibox.container.background,
    create_callback = function(item, tag, index, _)
      self:update_icon(item:get_children_by_id('img_tag')[1], tag, index)
      update_bg(item:get_children_by_id('img_tag_bg')[1])
    end,
    update_callback = function(item, tag, index, _)
      self:update_icon(item:get_children_by_id('img_tag')[1], tag, index)
      update_bg(item:get_children_by_id('img_tag_bg')[1])
    end
  }
  return t
end

-- herit
local taglist_widget = class(taglist_root)

function taglist_widget:init(s, args)
  taglist_root.init(self, args)

  local widgets = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = self.buttons,
    layout = self.layout,
    widget_template = self.template
  }
  return widgets
end

return taglist_widget
