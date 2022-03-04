local wibox = require('wibox')
local helpers = require('lib.helpers')
local button_outlined = require('lib.button-outlined')
local button_text = require('lib.button-text')

local music = class()

function music:init()
  self.title = self:title()
  self.image = self:image()
  self.progressbar = self:progressbar(33)
  return wibox.widget {
    {
      self:top(),
      self:middle(),
      self:bottom(),
      expand = 'none',
      layout = wibox.layout.align.vertical
    },
    left = dpi(12), right = dpi(12),
    bottom = dpi(16), top = dpi(16),
    widget = wibox.container.margin
  }
end

function music:image()
  return wibox.widget {
    image = '/home/daggoth/images/thumb-1920-609120.jpg',
    widget = wibox.widget.imagebox
  }
end

function music:progressbar(value)
  return wibox.widget {
    max_value     = 1,
    value         = value,
    max_value     = 100,
    forced_height = 10,
    forced_width  = 100,
    paddings      = 1,
    color = md.sys.color.secondary,
    background_color = md.sys.color.secondary
      .. md.sys.elevation.level1,
    shape = helpers.rrect(dpi(20)),
    widget        = wibox.widget.progressbar,
  }
end

function music:top()
  return wibox.widget {
    {
      text = 'MPD status:',
      widget = wibox.widget.textbox
    },
    layout = wibox.layout.fixed.vertical
  }
end

function music:title()
  return wibox.widget {
    {
      {
        text = '> TITLE',
        align = 'center',
        font = md.sys.typescale.body_medium.font
          .. ' ' .. md.sys.typescale.body_medium.size,
        widget = wibox.widget.textbox
      },
      {
        text = 'by AUTHOR',
        align = 'center',
        font = md.sys.typescale.body_small.font
          .. ' ' .. md.sys.typescale.body_small.size,
        widget = wibox.widget.textbox
      },
      widget = wibox.layout.fixed.vertical
    },
    top = dpi(20),
    widget = wibox.container.margin
  }
end

function music:middle()
  return wibox.widget {
    {
      self.title,
      {
        self.image,
        {
          self.progressbar,
          top = dpi(20),
          left = dpi(10), right = dpi(10),
          widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
      },
      {
        nil,
        {
          {
            button_text({
              icon = '󰼨',
            }),
            button_outlined({
              icon = '󰼛',
            }),
            button_text({
              icon = '󰼧',
            }),
            spacing = dpi(8),
            layout = wibox.layout.fixed.horizontal
          },
          bottom = dpi(10),
          widget = wibox.container.margin
        },
        expand = 'none',
        layout = wibox.layout.align.horizontal
      },
      expand = 'none',
      layout = wibox.layout.align.vertical
    },
    bg = md.sys.color.primary .. md.sys.elevation.level1,
    forced_height = dpi(400),
    shape = helpers.rrect(dpi(28)),
    widget = wibox.container.background
  }
end

function music:bottom()
  return wibox.widget {
    {
      text = 'Playlists',
      widget = wibox.widget.textbox
    },
    {
      button_outlined({
        text = 'EBSM'
      }),
      button_outlined({
        text = 'CLAS'
      }),
      button_outlined({
        text = 'SPAC'
      }),
      spacing = dpi(8),
      layout = wibox.layout.fixed.horizontal
    },
    layout = wibox.layout.fixed.vertical
  }
end

return music
