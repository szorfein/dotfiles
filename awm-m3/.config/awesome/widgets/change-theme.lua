local wibox = require('wibox')
local awful = require('awful')

local change_theme = class()

function change_theme:init()
  self.img_dir = os.getenv('HOME') .. '/images/'
  self.script = os.getenv('HOME') .. '/.config/awesome/scripts/stow.sh'

  self.dialog_change_theme = require('lib.dialog')({
    name = 'change_theme',
    title = 'Change theme',
    widget = self:dialog_widget()
  })

  self.dialog_change_theme:centered()

  return require('lib.button-icon')({
    icon = '󰌁',
    fg = md.sys.color.on_surface_variant,
    cmd = function() self.dialog_change_theme:display() end
  }).widget
end

function change_theme:dialog_widget()
  local themes = {
    [1] = { "Beta", self.img_dir .. 'beta.jpg', self.script .. ' beta' },
    [2] = { "Lines", self.img_dir .. 'lines.jpg', self.script .. ' lines' },
    [3] = { "Morpho", self.img_dir .. 'morpho.jpg', self.script .. ' morpho' },
    [4] = { "Miami", self.img_dir .. 'miami.jpg', self.script .. ' miami' },
    [5] = { "Sci", self.img_dir .. 'sci.jpg', self.script .. ' sci' },
    [6] = { "Focus", self.img_dir .. '1330479.png', self.script .. ' focus' },
  }

  local layout = wibox.widget {
    spacing = dpi(8),
    forced_num_rows = 2, forced_num_cols = 3,
    layout = wibox.layout.grid
  }

  for _, value in pairs(themes) do
    local w = wibox.widget {
      require('lib.card-outlined')({
        title = value[1],
        image = value[2],
        on_click = function()
          awful.spawn.easy_async_with_shell(value[3], function(stdout, stderr, _, exit_code)
            if exit_code == 0 then
              awesome.restart()
            else
              require('naughty').notify({ title = 'err', text = stdout .. " - " .. stderr })
            end
          end)
        end
      }),
      layout = wibox.layout.fixed.horizontal
    }

    layout:add(w)
  end

  return layout
end

return change_theme()
