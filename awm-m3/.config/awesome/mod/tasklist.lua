local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local helpers = require('lib.helpers')

local tasklist = class()

function tasklist:init(args)
  self.screen = args.screen or awful.screen.focused()
  self.style = {
    shape = helpers.rrect(dpi(8)),
    bg = md.sys.color.surface
  }
  self.layout = {
    spacing = dpi(8),
    layout = wibox.layout.fixed.horizontal
  }
  self.w = self:create()
end

function tasklist:create()
  return awful.widget.taglist {
    screen = self.screen,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = self:buttons(),
    layout = {
      spacing = dpi(8),
      layout = wibox.layout.fixed.horizontal
    },
    style = {
      shape = helpers.rrect(dpi(8)),
      bg = md.sys.color.surface
    },
    widget_template = self:template()
  }
end

function tasklist:buttons()
  return gears.table.join(
    awful.button({}, 1, function(c)
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
    end)
  )
end

function tasklist:normal(item, hovered)
  local hover = hovered or false
  local state = item:get_children_by_id('tasklist_state')[1]
  item.fg = md.sys.color.on_surface_variant
  state.shape = helpers.rrect(dpi(8))
  state.bg = hover
    and md.sys.color.on_surface_variant .. md.sys.state.hover_state_layer_opacity
    or md.sys.color.surface_tint_color .. md.sys.elevation.level1
end

function tasklist:minimize(item)
  local state = item:get_children_by_id('tasklist_state')[1]
  item.fg = md.sys.color.on_surface .. md.sys.state.disable_content_opacity
  state.shape = helpers.rrect(dpi(8))
  state.bg = md.sys.color.on_surface .. md.sys.state.disable_container_opacity
end

function tasklist:focus(item, hovered)
  local hover = hovered or false
  local state = item:get_children_by_id('tasklist_state')[1]
  item.fg = md.sys.color.on_secondary_container
  state.shape = helpers.rrect(dpi(8))
  state.bg = hover
    and md.sys.color.on_secondary_container .. md.sys.state.hover_state_layer_opacity
    or md.sys.color.on_secondary_container .. md.sys.state.focus_state_layer_opacity
end

function tasklist:template()
  return {
    {
      {
        {
          {
            id = 'icon',
            font = md.sys.typescale.label_large.font .. ' ' .. dpi(18),
            widget = wibox.widget.textbox
          },
          {
            id = 'name',
            font = md.sys.typescale.label_large.font
              .. ' ' .. md.sys.typescale.label_large.size,
            widget = wibox.widget.textbox
          },
          spacing = dpi(8),
          layout = wibox.layout.fixed.horizontal
        },
        left = dpi(8), right = dpi(16),
        widget = wibox.container.margin
      },
      id = 'tasklist_state',
      widget = wibox.container.background
    },
    id = 'background_role',
    widget = wibox.container.background,
    create_callback = function(s, c, index, objects) --luacheck: no unused args
      self:make_icon_and_text(s, c)
      self:add_signals(s, c)
      self:base_rule(s, c)
    end,
    update_callback = function(s, c, index, objects) --luacheck: no unused args
      self:base_rule(s, c)
    end,
  }
end

function tasklist:make_icon_and_text(item, c)
  if c.class == 'Firefox' then
    item:get_children_by_id('icon')[1].text = ''
    item:get_children_by_id('name')[1].text = 'firefox'
  elseif c.class == 'Emacs' then
    item:get_children_by_id('icon')[1].text = ''
    item:get_children_by_id('name')[1].text = 'emacs'
  elseif c.name:match('vim') then
    item:get_children_by_id('icon')[1].text = ''
    item:get_children_by_id('name')[1].text = 'vim'
  elseif c.class == 'xst-256color' then
    item:get_children_by_id('icon')[1].text = ''
    item:get_children_by_id('name')[1].text = 'xst'
  elseif c.class == 'feh' then
    item:get_children_by_id('icon')[1].text = ''
    item:get_children_by_id('name')[1].text = 'feh'
  else
    item:get_children_by_id('name')[1].text = c.name .. ' | ' .. c.class
  end
end

function tasklist:add_signals(item, c)
  self:signal_hover(item, c)
  self:signal_hover_leave(item, c)
end

function tasklist:signal_hover(item, c)
  item:connect_signal('mouse::enter', function()
    if c.minimized then
      self:minimize(item)
    elseif client.focus and c == client.focus then
      self:focus(item, true)
    else
      self:normal(item, true)
    end
  end)
end

function tasklist:signal_hover_leave(item, c)
  item:connect_signal('mouse::leave', function()
    if c.minimized then
      self:minimize(item)
    elseif client.focus and c == client.focus then
      self:focus(item)
    else
      self:normal(item)
    end
  end)
end

function tasklist:base_rule(item, c)
  if c.minimized then
    self:minimize(item)
  elseif client.focus and c == client.focus then
    self:focus(item)
  else
    self:normal(item)
  end
end

local main = class(tasklist)

function main:init(args)
  tasklist.init(self, args)

  return awful.widget.tasklist {
    screen  = self.screen,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = self:buttons(),
    layout = self.layout,
    style = self.style,
    widget_template = self:template()
  }
end

return main
