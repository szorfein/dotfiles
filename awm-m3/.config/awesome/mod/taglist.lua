local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local helpers = require('lib.helpers')

local taglist = class()

function taglist:init(args)
  self.screen = args.screen or awful.screen.focused()
  self.style = self:styles()
  self.layout = {
    spacing = dpi(8),
    layout = wibox.layout.fixed.vertical
  }
end

function taglist:styles()
  return {
    shape = helpers.circle(),
    bg_focus = md.sys.color.secondary_container,
    fg_urgent = md.sys.color.tertiary,
    bg_urgent = md.sys.color.surface .. 00,
    font = md.sys.typescale.icon.font
      .. ' ' .. dpi(16)
  }
end

function taglist:buttons()
  return gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
  )
end

function taglist:signals(item, tag)
  self:signal_hover(item, tag)
  self:signal_hover_leave(item, tag)
end

function taglist:signal_hover(item, tag)
  item:connect_signal('mouse::enter', function()
    self:hovered(item, tag)
  end)
end

function taglist:signal_hover_leave(item, tag)
  item:connect_signal('mouse::leave', function()
    self:enabled(item, tag)
  end)
end

function taglist:font(tag)
  local is_active = #tag:clients() >= 1 and true or false
  local font = is_active
    and md.sys.color.on_secondary_container
    or md.sys.color.on_surface_variant
  return font
end

-- enabled
function taglist:enabled(item, tag)
  item.fg = self:font(tag)
  local state = item:get_children_by_id('taglist_state')[1]
  state.bg = self:font(tag) .. md.sys.elevation.level0
  state.shape = self:active_indicator_shape(tag)
  item.bg = self:active_indicator(tag)
end

-- hovered
function taglist:hovered(item, tag)
  local state = item:get_children_by_id('taglist_state')[1]
  item.fg = self:font(tag)
  state.bg = self:font(tag) .. md.sys.state.hover_state_layer_opacity
  state.shape = self:active_indicator_shape(tag)
  item.bg = self:active_indicator(tag)
end

function taglist:active_indicator_shape(tag)
  return helpers.circle()
end

function taglist:active_indicator(tag)
  local is_active = tag.selected or false
  local color = is_active
    and md.sys.color.secondary_container
    or md.sys.color.surface .. md.sys.elevation.level0
  return color
end

function taglist:template()
  return {
    {
      {
        id = 'text_role',
        align = 'center',
        widget = wibox.widget.textbox,
      },
      id = 'taglist_state',
      widget = wibox.container.background
    },
    id = 'background_role',
    forced_height = dpi(56),
    forced_width = dpi(56),
    widget = wibox.container.background,
    create_callback = function(item, c3, index, objects) --luacheck: no unused args
      item:get_children_by_id('text_role')[1].markup = '<b> '..index..' </b>'
      self:enabled(item, c3)
      self:signals(item, c3)
    end,
    update_callback = function(item, c3, index, objects) --luacheck: no unused args
      self:enabled(item, c3)
    end
  }
end

local main = class(taglist)

function main:init(args)
  taglist.init(self, args)

  return awful.widget.taglist {
    screen  = self.screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = self:buttons(),
    style   = self.style,
    layout  = self.layout,
    widget_template = self:template()
  }
end

return main
