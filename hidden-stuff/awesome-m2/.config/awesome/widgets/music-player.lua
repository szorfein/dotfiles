local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local icons = require("icons.default")
local font = require("util.font")
local button = require("utils.button")
local ufont = require("utils.font")

local music_player_root = class()

function music_player_root:init(args)
  -- options
  self.fg = args.fg or beautiful.widget_volume_fg or M.x.on_background
  self.icon = args.icon or beautiful.widget_mpc_button_icon or { "", M.x.on_background }
  self.mode = args.mode or 'popup' -- possible values: block, popup, song
  self.wibar_position = args.wibar_position or beautiful.wibar_position or "top"
  self.wibar_size = args.wibar_size or beautiful.wibar_size or dpi(56)
  self.wposition = args.position or widget.check_popup_position(self.wibar_position)
  -- widgets
  --self.wicon = font.button(self.icon[1], self.icon[2])
  self.wicon = button({
    fg_icon = self.icon[2],
    icon = ufont.button(self.icon[1])
  })
  self.title = font.button("")
  self.artist = font.caption("")
  self.cover = widget.imagebox(90)
  self.time_pasted = font.caption("")
  self.widget = self:make_widget()
end

function music_player_root:make_widget()
  if self.mode == "block" then
    return self:make_block()
  end
end

function music_player_root:make_block()
  local mpc = require("widgets.mpc")({ no_margin = true }) -- mini block, no need margin
  self.title.align = "left"
  self.cover.forced_height = dpi(60)
  self.cover.forced_width = dpi(60)
  local w = wibox.widget {
    {
      self.cover,
      {
        nil,
        {
          {
            self.title,
            forced_height = dpi(20), -- one line
            left = dpi(10),
            widget = wibox.container.margin
          },
          mpc,
          layout = wibox.layout.fixed.vertical
        },
        expand = "none",
        layout = wibox.layout.align.vertical
      },
      layout = wibox.layout.align.horizontal
    },
    forced_height = 80,
    top = dpi(10), bottom = dpi(10), -- adjust in order to limit the name to one line
    widget = wibox.container.margin
  }
  self:signals()
  return w
end

-- update
function music_player_root:updates(title, artist)
  -- default value
  local title = title ~= nil and title or 'Unknown'
  local artist = artist ~= nil and artist or 'Unknown'

  self.title.markup = helpers.colorize_text(title:sub(1,20), M.x.error)
  self.artist.markup = helpers.colorize_text("By "..artist, M.x.primary)
end

function music_player_root:update_time(time)
  if time then
    self.time_pasted.markup = helpers.colorize_text(time, M.x.secondary)
  end
end

function music_player_root:update_cover(cover)
  if cover then
    local img = cover or icons["default_cover"]
    self.cover.image = img
  end
end

-- signals
function music_player_root:signals()
  awesome.connect_signal("daemon::mpd_infos", function(title, artist)
    if title and artist then
      --naughty.notify({ text = tostring(mpd.cover) })
      self:updates(title, artist)
    end
  end)
  awesome.connect_signal("daemon::mpd_cover", function(cover)
    self:update_cover(cover)
  end)
  awesome.connect_signal("daemon::mpd_time", function(time)
    self:update_time(time)
  end)
end

-- herit
local music_player_widget = class(music_player_root)

function music_player_widget:init(args)
  music_player_root.init(self, args)
  return self.widget
end

return music_player_widget
