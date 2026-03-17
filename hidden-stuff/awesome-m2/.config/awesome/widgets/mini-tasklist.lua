local awful = require("awful")
local table = require("gears.table")
local wibox = require("wibox")
local beautiful = require("beautiful")
local font = require("utils.font")
local helper = require("utils.helper")
local icons = require("config.icons")

beautiful.tasklist_font = M.f.subtile_2

local tasklist_root = class()

function tasklist_root:init(args)
  self.template = self:select_template()
  self.buttons = self:make_buttons()
end

function tasklist_root:select_template()
    return self:template_text() -- default
end

function tasklist_root:make_buttons()
  local button = table.join(
    awful.button({}, 1, function(c)
      if c == client.focus then
        c.minimized = true
      else
        c:emit_signal(
         "request::activate",
         "tasklist",
         { raise = true }
        )
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
  return button
end

local function update_icon(item, c)
  if c.class == "Firefox" or c.class == "Brave-browser" then
    item.text = icons.app["web"]
  elseif c.name == "neomutt" then
    item.text = icons.app["neomutt"]
  elseif c.name == "weechat" then
    item.text = icons.app["weechat"]
  elseif c.name:match("ncmpcpp") then
    item.text = icons.app["ncmpcpp"]
  elseif c.name == "vifm" then
    item.text = icons.app["vifm"]
  elseif c.class == "feh" then
    item.text = icons.app["feh"]
  elseif c.class == "mpv" then
    item.text = icons.app["mpv"]
  elseif c.name:match("paranoid") then
    item.text = icons.app["paranoid"]
  elseif c.name:match("spior") then
    item.text = icons.app["spior"]
  elseif c.name == "cava" then
    item.text = icons.app["cava"]
  elseif c.name:match("VIM") then
    item.text = icons.app["vim"]
  elseif c.class:match("VirtualBox") then
    item.text = icons.app["virtualbox"]
  elseif c.class == "Zathura" then
    item.text = icons.app["zathura"]
  elseif c.class == "Lutris" then
    item.text = icons.app["lutris"]
  elseif c.class:match("xst") then
    item.text = icons.app["xst"]
  else
    item.text = icons.app["default"]
  end
end

local function update_fg(item, c)
  if client.focus == c then
    item.fg = M.x.on_background .. "E6" -- 90%
  elseif client.unfocus == c then
    item.fg = M.x.on_background .. "B3" -- 70%
  elseif client.minimized == c then
    item.fg = M.x.on_background .. "80" -- 50%
  elseif client.urgent == c then
    item.fg = M.x.on_error .. "FF"
  else
    item.fg = M.x.on_background .. "80" -- 50%
  end
end

local function update_bg(item, c)
  if client.focus == c then
    item.bg = M.x.on_background .. "0D" -- 5%
  elseif client.unfocus == c then
    item.bg = M.x.on_background .. "0D" -- 5%
  elseif client.minimized == c then
    item.bg = M.x.error .. "0A" -- 4%
  elseif client.urgent == c then
    item.bg = M.x.error .. "FF"
  else
    item.bg = M.x.on_background .. "00" -- 0%
  end
end

function tasklist_root:template_text() 
  local t = {
    {
      {
        {
          {
            {
              id = 'text_icon',
              font = M.f.icon,
              widget = wibox.widget.textbox
            },
            id = "mat_fg",
            widget = wibox.container.background
          },
          --{
          --  id = 'text_role',
          --  widget = wibox.widget.textbox,
          --},
          spacing = dpi(8),
          layout = wibox.layout.fixed.horizontal,
        },
        left = dpi(8), right = dpi(8),
        --top = dpi(2), bottom = dpi(2), -- one line only !
        widget = wibox.container.margin
      },
      id = 'mat_background',
      shape = helper.rrect(16),
      widget = wibox.container.background,
    },
    --id = 'background_role',
    widget = wibox.container.background,
    create_callback = function(self, c, index, objects)

      local icon = self:get_children_by_id('text_icon')[1]
      update_icon(icon, c)

      local bg = self:get_children_by_id('mat_background')[1]
      update_bg(bg, c)

      local fg = self:get_children_by_id('mat_fg')[1]
      update_fg(fg, c)
    end,
    update_callback = function(self, c, index, objects)

      local icon = self:get_children_by_id('text_icon')[1]
      update_icon(icon, c)

      local bg = self:get_children_by_id('mat_background')[1]
      update_bg(bg, c)

      local fg = self:get_children_by_id('mat_fg')[1]
      update_fg(fg, c)
    end,
  }
  return t
end

local tasklist_widget = class(tasklist_root)

function tasklist_widget:init(s, args)
  tasklist_root.init(self, args)

  local w = awful.widget.tasklist {
    screen = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    --filter =  awful.widget.tasklist.filter.minimizedcurrenttags, -- TODO: no work for now? try with the 4.4
    buttons = self.buttons,
    widget_template = self.template,
    layout = {
      layout = wibox.layout.fixed.horizontal
    }
  }
  return w
end

return tasklist_widget
