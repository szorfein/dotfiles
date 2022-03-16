local wibox = require('wibox')
local awful = require('awful')
local naughty = require('naughty')
local helpers = require('lib.helpers')
local button_outlined = require('lib.button-outlined')
local button_text = require('lib.button-text')
local dialog = require('lib.dialog')

local music = class()

function music:init()
  self.mpd_status = button_text({
    icon = '󰽢',
    fg = md.sys.color.error,
    cmd = self.start
  })
  self.title = self:title()
  self.artist = self:artist()
  self.image = self:image()
  self.progressbar = self:progressbar()
  self.mpc_toggle = button_outlined({
    icon = '󰼛',
    cmd = function()
      awful.spawn.with_shell("mpc -q toggle")
    end
  }),
  self:signals()
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

function music:signals()
  awesome.connect_signal('daemon::mpd', function(status)
    if status then
      self.mpd_status:setup {
        button_text({
          icon = '󰽢',
          fg = md.sys.color.primary,
          cmd = self.start
        }),
        layout = wibox.layout.fixed.horizontal
      }
    else
      self.mpd_status:setup {
        button_text({
          icon = '󰽢',
          fg = md.sys.color.error,
          cmd = self.start
        }),
        layout = wibox.layout.fixed.horizontal
      }
    end
  end)
  awesome.connect_signal('daemon::mpc', function(img, artist, title, paused)
    self.title.text = title and title or 'N/A'
    self.artist.text = artist and 'by ' .. artist or 'by N/A'
    self.image.image = img and img or '/home/daggoth/images/thumb-1920-609120.jpg'

    local toggle = self.mpc_toggle:get_all_children()[5]
    local pause = paused and paused or false
    toggle.text = pause and '󰼛' or '󰏤'
  end)
  awesome.connect_signal('daemon::mpc_timer', function(time)
    self.progressbar.value = time and tonumber(time) or 0
  end)
end

function music:image()
  return wibox.widget {
    image = '/home/daggoth/images/thumb-1920-609120.jpg',
    widget = wibox.widget.imagebox
  }
end

function music:progressbar()
  return wibox.widget {
    max_value     = 1,
    value         = 1,
    max_value     = 100,
    forced_height = 10,
    forced_width  = 100,
    paddings      = 1,
    color = md.sys.color.secondary,
    background_color = md.sys.color.secondary
      .. md.sys.elevation.level1,
    widget        = wibox.widget.progressbar,
  }
end

function music:start()
  local script = [[
#!/usr/bin/env sh

set -o errexit -o nounset

if [ -s "$HOME"/.config/mpd/pid ] ; then
  pgrep -x mpd 2>/dev/null | xargs kill
else
  mpd
  mpc idleloop player &
fi
]]

  awful.spawn.easy_async_with_shell(script, function(_, _, _, exit_code)
    naughty.notify({ title = 'mpd', text = tostring(exit_code) })
  end)
end

function music:top()
  local top = wibox.widget {
    {
      {
        text = 'MPD',
        font = md.sys.typescale.title_medium.font
          .. ' ' .. md.sys.typescale.title_medium.size,
        widget = wibox.widget.textbox
      },
      nil,
      self.mpd_status,
      expand = 'none',
      layout = wibox.layout.align.horizontal
    },
    margins = dpi(16),
    widget = wibox.container.margin
  }
  return top
end

function music:title()
  return wibox.widget {
    align = 'center',
    font = md.sys.typescale.title_medium.font
      .. ' ' .. md.sys.typescale.title_medium.size,
    forced_height = dpi(24),
    widget = wibox.widget.textbox
  }
end

function music:artist()
  return wibox.widget {
    align = 'center',
    font = md.sys.typescale.body_small.font
      .. ' ' .. md.sys.typescale.body_small.size,
    forced_height = dpi(24),
    widget = wibox.widget.textbox
  }
end

function music:description()
  return wibox.widget {
    {
      self.title,
      self.artist,
      spacing = dpi(8),
      widget = wibox.layout.fixed.vertical
    },
    margins = dpi(20),
    widget = wibox.container.margin
  }
end

function music:all_mpc_buttons()
  return wibox.widget {
    button_text({
      icon = '󰐒',
      fg = md.sys.color.on_surface,
      cmd = function() dialog:centered(
        'Save playlist to',
        self:save_playlist()
      ) end
    }),
    button_text({
      icon = '󰒝',
      fg = md.sys.color.on_surface,
      cmd = function()
        awful.spawn.with_shell('mpc shuffle')
      end
    }),
    button_text({
      icon = '󰑖',
      fg = md.sys.color.on_surface,
      cmd = function()
        awful.spawn.with_shell('mpc repeat')
      end
    }),
    button_text({
      icon = '󱐰',
      fg = md.sys.color.error,
      cmd = function()
        awful.spawn.with_shell("mpc del 0")
      end
    }),
    layout = wibox.layout.fixed.horizontal
  }
end

function music:save_playlist()
  local textbox = wibox.widget {
    font = md.sys.typescale.body_medium.font
      .. ' ' .. md.sys.typescale.body_medium.size,
    widget = wibox.widget.textbox
  }
  awful.prompt.run {
    prompt       = '<b>Name: </b>',
    textbox      = textbox,
    font = md.sys.typescale.body_medium.font
      .. ' ' .. md.sys.typescale.body_medium.size,
    exe_callback = function(input)
      if not input or #input == 0 then return end
      awful.spawn.easy_async_with_shell([[sh -c '
        mpc save ]] .. tostring(input) .. [[
      ']], function(_, stderr, _, exit_code)

        if exit_code == 0 then
          naughty.notify{ title = 'Playlist',
            text = 'Saved to :  '.. input }
        else
          naughty.notify{ text = stderr }
        end
      end)
    end,
    done_callback = function()
      dialog:hide()
    end
  }
  return wibox.widget {
    {
      {
        textbox,
        margins = dpi(8),
        widget = wibox.container.margin
      },
      shape = helpers:rrect(dpi(12)),
      bg = md.sys.color.primary .. md.sys.elevation.level1,
      shape_border_width = 1,
      shape_border_color = md.sys.color.outline,
      widget = wibox.container.background
    },
    layout = wibox.layout.fixed.vertical
  }
end

function music:middle()
  return wibox.widget {
    {
      {
        self.progressbar,
        {
          nil,
          {
            self:all_mpc_buttons(),
            margins = dpi(12),
            widget = wibox.container.margin
          },
          expand = 'none',
          layout = wibox.layout.align.horizontal
        },
        layout = wibox.layout.fixed.vertical
      },
      {
        self.image,
        {
          self:description(),
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
              cmd = function()
                awful.spawn.with_shell("mpc -q prev")
              end
            }),
            self.mpc_toggle,
            button_text({
              icon = '󰼧',
              cmd = function()
                awful.spawn.with_shell("mpc -q next")
              end
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
    forced_height = dpi(480),
    shape = helpers:prect(dpi(28)),
    widget = wibox.container.background
  }
end

function music:bottom()
  return wibox.widget {
    {
      nil,
      {
        button_text({
          icon = '󰲹',
          text = 'playlists',
          cmd = function() dialog:centered(
            'Playlist',
            self:playlist()
          ) end
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

function music:playlist()
  local widget = wibox.widget {
    layout = wibox.layout.fixed.vertical
  }
  awful.spawn.with_line_callback([[sh -c 'mpc lsplaylists']], {
    stdout = function(line)
      local w = button_text({
        text = tostring(line),
        cmd = function()
          awful.spawn.easy_async_with_shell([[sh -c '
          mpc clear
          mpc load ]] .. tostring(line) .. [[ && mpc play
          ']], function(_)
            naughty.notify({ title = 'Playlist',
              text = tostring(line) .. ' loaded'
            })
          end)
        end
      })
      widget:add(w)
    end
  })
  return widget
end

return music
