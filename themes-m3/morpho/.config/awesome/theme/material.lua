local fonts = require('lib.fonts')

local theme = {
  name = 'morpho',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'morpho.jpg',
  color = {},
  typescale = fonts.iosevka()
}

theme.color.primary = '#CDBDFF'
theme.color.on_primary = '#361387'
theme.color.primary_container = '#644AB6'
theme.color.on_primary_container = '#FFFFFF'
theme.color.secondary = '#CCBFF1'
theme.color.on_secondary = '#332A52'
theme.color.secondary_container = '#433A63'
theme.color.on_secondary_container = '#DBCEFF'
theme.color.tertiary = '#FFADE2'
theme.color.on_tertiary = '#5F004E'
theme.color.tertiary_container = '#97387F'
theme.color.on_tertiary_container = '#FFFFFF'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#948E9E'
theme.color.background = '#141219'
theme.color.on_background = '#E6E0EA'
theme.color.surface = '#141219'
theme.color.on_surface = '#E6E0EA'
theme.color.surface_variant = '#494552'
theme.color.on_surface_variant = '#CAC4D4'
theme.color.inverse_surface = '#E6E0EA'
theme.color.inverse_on_surface = '#322F37'
theme.color.inverse_primary = '#654BB8'
theme.color.surface_tint_color = '#CDBDFF'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'
theme.color.surface_container = '#211F26'

return theme
