local wibox = require('wibox')
local helpers = require('lib.helpers')
local button_outlined = require('lib.button-outlined')
local button_text = require('lib.button-text')
local chip_suggestion = require('lib.chip-suggestion')
local card = require('lib.card-elevated')

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
  local top = wibox.widget {
    {
      nil,
      {
        {
          text = 'MPD',
          font = md.sys.typescale.title_medium.font
            .. ' ' .. md.sys.typescale.title_medium.size,
          widget = wibox.widget.textbox
        },
        nil,
        {
          {
            text = '󰽢',
            font = md.sys.typescale.icon.font .. ' ' .. dpi(18),
            widget = wibox.widget.textbox
          },
          fg = md.sys.color.error,
          widget = wibox.container.background
        },
        expand = 'none',
        layout = wibox.layout.align.horizontal
      },
      {
        nil,
        nil,
        {
          button_text({
            text = 'Stop',
            fg = md.sys.color.on_surface_variant
          }),
          button_outlined({
            text = 'Start'
          }),
          spacing = dpi(8),
          layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
      },
      spacing = dpi(16),
      layout = wibox.layout.fixed.vertical
    },
    expand = 'none',
    layout = wibox.layout.fixed.vertical
  }
  return card:elevated(top)
end

function music:title()
  return wibox.widget {
    {
      {
        text = 'TITLE',
        align = 'center',
        font = md.sys.typescale.title_medium.font
          .. ' ' .. md.sys.typescale.title_medium.size,
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
      nil,
      {
        chip_suggestion({
          text = 'ebsm',
          fg = md.sys.color.primary
        }),
        chip_suggestion({
          text = 'clas'
        }),
        chip_suggestion({
          text = 'rock',
          fg = md.sys.color.tertiary
        }),
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal
      },
      expand = 'none',
      layout = wibox.layout.align.horizontal
    },
    {
      nil,
      {
        chip_suggestion({
          text = 'chil'
        }),
        chip_suggestion({
          text = 'lofi',
          fg = md.sys.color.on_surface
        }),
        chip_suggestion({
          text = 'folk'
        }),
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal
      },
      expand = 'none',
      layout = wibox.layout.align.horizontal
    },
    spacing = dpi(8),
    layout = wibox.layout.fixed.vertical
  }
end

return music
