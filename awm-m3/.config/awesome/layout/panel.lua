local awful = require('awful')
local wibox = require('wibox')
local text_button = require('lib.mat.text-button')

-- https://m3.material.io/m3/pages/foldable-devices/compositions#1fe03735-f0ad-4721-9e00-253e6988beed
local panel = class()

function panel:init(args)
  self.screen = args.screen or awful.screen.focused()
  self.width = dpi(256)
  self.screen.panel = wibox(self:wibox_args())
  self:setup()
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
      text_button({
        content = 'm',
        cmd = function()
          self:music_panel()
        end
      }),
      text_button({
        content = 'c',
        cmd = function()
          self:control_panel()
        end
      }),
      layout = wibox.layout.fixed.horizontal
    },
    nil, -- center
    text_button({ -- right
      content = 'ﰸ',
      cmd = function() self:hide() end,
    }),
    layout = wibox.layout.align.horizontal
  }
end

function panel:control_panel()
  self.screen.panel:setup {
    self:head_buttons(),
    require('layout.panel-control')(),
    layout = wibox.layout.align.vertical
  }
end

function panel:music_panel()
  self.screen.panel:setup {
    self:head_buttons(),
    require('layout.panel-music')(),
    layout = wibox.layout.align.vertical
  }
end

-- default panel
function panel:setup()
  self:music_panel()
end

return panel
