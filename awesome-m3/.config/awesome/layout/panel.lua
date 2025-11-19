local awful = require('awful')
local wibox = require('wibox')
local button_icon = require('lib.button-icon')

-- https://m3.material.io/m3/pages/foldable-devices/compositions#1fe03735-f0ad-4721-9e00-253e6988beed
local panel = class()

function panel:init(screen)
  self.screen = screen or awful.screen.focused()
  self.width = dpi(256)

  self.music = require('layout.panel-music')()
  self.music_button = button_icon({
    icon = '󰋋',
    fg = md.sys.color.on_surface_variant,
    cmd = function()
      self:music_panel()
    end
  })

  self.control = require('layout.panel-control')()
  self.control_button = button_icon({
    icon = '󱎴',
    fg = md.sys.color.on_surface_variant,
    cmd = function()
      self:control_panel()
    end
  })

  self.screen.panel = wibox(self:wibox_args())
  self:setup()
  self:signals()
end

function panel:show()
  local left_pad = self.screen.rail.visible and dpi(80) or 0
  self.screen.padding = { left = left_pad, right = self.width }
  awful.placement.top_right(self.screen.panel)
  awful.placement.maximize_vertically(self.screen.panel)
  self.screen.panel.visible = true
end

function panel:hide()
  local left_pad = self.screen.rail.visible and dpi(80) or 0
  self.screen.padding = { left = left_pad, right = 0 }
  self.screen.panel.visible = false
end

function panel:wibox_args()
  return {
    screen = self.screen,
    ontop = true,
    visible = false,
    x = 0,
    y = 0,
    width = self.width,
    height = self.screen.geometry.height
  }
end

function panel:head_buttons()
  return wibox.widget {
    {
      self.music_button.widget,
      self.control_button.widget,
      layout = wibox.layout.fixed.horizontal
    },
    nil, -- center
    button_icon({ -- right
      icon = '󰖭',
      fg = md.sys.color.tertiary,
      cmd = function() self:hide() end,
    }).widget,
    layout = wibox.layout.align.horizontal
  }
end

function panel:control_panel()
  self.music_button:disable()
  self.control_button:set_color(md.sys.color.primary)

  self.screen.panel:setup {
    self:head_buttons(),
    self.control,
    layout = wibox.layout.align.vertical
  }
end

function panel:music_panel()
  self.control_button:disable()
  self.music_button:set_color(md.sys.color.primary)

  self.screen.panel:setup {
    self:head_buttons(),
    self.music,
    layout = wibox.layout.align.vertical
  }
end

-- default panel
function panel:setup()
  self:music_panel()
end

-- Activate panel by moving the mouse at the edge of the screen
function panel:signals()
  self.screen.panel_activator = wibox({y = 0, width = 1, visible = true, ontop = false, opacity = 0, below = true, screen = self.screen})

  self.screen.panel_activator.height = self.screen.geometry.height
  awful.placement.right(self.screen.panel_activator)

  self.screen.panel_activator:connect_signal('mouse::enter', function()
    self:show()
  end)
end

return panel
