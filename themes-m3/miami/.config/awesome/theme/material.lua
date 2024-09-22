local fonts = require('lib.fonts')

local theme = {
  name = 'miami',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'miami.jpg',
  color = {},
  typescale = fonts.iosevka()
}

theme.color.primary = '#FFB3B0'
theme.color.on_primary = '#68000F'
theme.color.primary_container = '#D23E43'
theme.color.on_primary_container = '#FFFFFF'
theme.color.secondary = '#FFB3B0'
theme.color.on_secondary = '#5B191A'
theme.color.secondary_container = '#6F2828'
theme.color.on_secondary_container = '#FFC7C4'
theme.color.tertiary = '#FFB86D'
theme.color.on_tertiary = '#492900'
theme.color.tertiary_container = '#A86400'
theme.color.on_tertiary_container = '#FFFFFF'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#A98988'
theme.color.background = '#1D100F'
theme.color.on_background = '#F7DDDB'
theme.color.surface = '#1D100F'
theme.color.on_surface = '#F7DDDB'
theme.color.surface_variant = '#59413F'
theme.color.on_surface_variant = '#E1BEBC'
theme.color.inverse_surface = '#F7DDDB'
theme.color.inverse_on_surface = '#3C2C2C'
theme.color.inverse_primary = '#B32730'
theme.color.surface_tint_color = '#FFB3B0'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'
theme.color.surface_container = '#2A1C1B'

return theme
