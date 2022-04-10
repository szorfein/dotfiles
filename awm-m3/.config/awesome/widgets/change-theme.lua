local wibox = require('wibox')
local awful = require('awful')
local card = require('lib.card-outlined')

local change_theme = class()

function change_theme:init()

  self.dialog_change_theme = require('lib.dialog')({ name = 'change_theme' })
  self.dialog_change_theme:centered(
    'Change theme',
    self:dialog_widget()
  )

  return require('lib.button-text')({
    icon = '󰌁',
    fg = md.sys.color.on_surface_variant,
    cmd = function() self.dialog_change_theme:display() end
  }).widget
end

function change_theme:dialog_widget()
  return wibox.widget {
    card({
      title = 'BETA',
      image = os.getenv('HOME') .. '/images/beta.jpg',
      on_click = function()
        awful.spawn.easy_async_with_shell('~/stow.sh beta-dark', function(_, stderr, _, exit_code)
          if exit_code == 0 then
            awesome:restart()
          else
            require('naughty')({ title = 'err', text = stderr })
          end
        end)
      end
    }),
    card({
      title = 'LINES',
      image = os.getenv('HOME') .. '/images/lines.jpg',
    }),
    spacing = dpi(8),
    layout = wibox.layout.fixed.horizontal
  }
end

return change_theme()
