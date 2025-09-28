local gtable = require("gears.table")
local awful = require("awful")
local wibox = require("wibox")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local helpers = require("helpers")

-- options
local spacing = beautiful.tasklist_spacing or dpi(4)
local align = beautiful.tasklist_align or "center"
local fg = beautiful.tasklist_fg_normal or M.x.on_background
local bg_normal = beautiful.tasklist_bg_normal or M.x.on_background .. M.e.dp00
local bg_focus = beautiful.tasklist_bg_focus or M.x.on_background .. M.e.dp01
local bg_urgent = beautiful.tasklist_bg_urgent or M.x.error

-- remove few symbols
beautiful.tasklist_plain_task_name=true

local tasklist_widget = {}

function tasklist_widget:buttons()
  local tasklist_buttons = gtable.join(
  awful.button({}, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))
  return tasklist_buttons
end

function cheer_update(w, c, index)
    w.markup = helpers.colorize_text(w.text, M.x.error, M.t.high)
  if c.focus then
    w.markup = helpers.colorize_text(w.text, M.x.error, M.t.high)
  elseif c.unfocus then
    w.markup = helpers.colorize_text(w.text, M.x.error, M.t.medium)
  else
    w.markup = helpers.colorize_text(w.text, M.x.error, M.t.disabled)
  end
end

function tasklist_widget:select_template()
  if beautiful.tasklist_icon_only then
    return self:template_icon()
  else
    return self:template()
  end
end

function tasklist_widget:template_icon()
  local t = {
    {
      {
        id     = "icon_role",
        forced_width = dpi(24),
        forced_height = dpi(24),
        widget = wibox.widget.imagebox
      },
      margins = dpi(14),
      widget = wibox.container.margin
    },
    id = "background_role",
    widget = wibox.container.background,
    create_callback = function(self, c, index, objects)
    end,
    update_callback = function(self, c, index, objects)
    end,
  }
  return t
end

function tasklist_widget:template()
  local t = {
    {
      {
        --nil,
        --{
          id = "text_role",
          widget = wibox.widget.textbox,
        --},
        --nil,
        --layout = wibox.layout.align.horizontal,
      },
      id = "text_margin_role",
      forced_width = beautiful.tasklist_width or dpi(200),
      left = dpi(15), right = dpi(15),
      top = dpi(10), bottom = dpi(10), -- adjust in order to limit the name to one line
      widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background,
    create_callback = function(self, c, index, objects)
              --for _, w in ipairs(self:get_children()) do
              --  noti.info("found 1"..tostring(w))
              --end
              --for i, o in ipairs(objects) do
              --  noti.info("found 2"..tostring(o))
              --  noti.info("found 2"..tostring(o["window"]))
              --end
      --local w = self:get_children_by_id("text_role")[1]
      local w = self:get_children_by_id("text_role")[1]
      --self:get_children_by_id("text_role")[1].markup = "<b> ".. self:get_children_by_id("text_role")[1].text.." </b>"
      --w.markup = "<b> ".. w.text.." </b>"
      cheer_update(w, c, index)
      self:get_children_by_id("text_role")[1].markup = helpers.colorize_text(self:get_children_by_id("text_role")[1].text, M.x.error, M.t.disabled)

      --cheer_update(w, tag, index)
    end,
    update_callback = function(self, c, index, objects)
      local w = self:get_children_by_id("text_role")[1]
      --self:get_children_by_id("text_role")[1].markup = "<b> ".. self:get_children_by_id("text_role")[1].text.." </b>"
      --w.markup = "<b> ".. w.text.." </b>"
      cheer_update(w, c, index)
      self:get_children_by_id("text_role")[1].markup = helpers.colorize_text(self:get_children_by_id("text_role")[1].text, M.x.error, M.t.disabled)

     -- local w = self:get_children_by_id("text_role")[1]
      --cheer_update(w, tag, index)
    end
  }
  return t
end

function tasklist_widget:new(s)
  local widget = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = self:buttons(),
    style = self.style,{
      --fg_normal = fg_normal,
      bg_normal = bg_normal or M.x.background,
      --fg_focus = fg_focus,
      bg_focus = bg_focus or M.x.background,
      align = align,
    },
    widget_template = self:select_template()
  }
  return widget
end

return setmetatable(tasklist_widget, {
  __call = tasklist_widget.new,
})
