local fonts = require('lib.fonts')

local theme = {
  name = 'miami',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'miami.jpg',
  color = {},
  typescale = fonts.iosevka()
}

theme.color.primary = '#FFB3B0'
theme.color.on_primary = '#571D1E'
theme.color.primary_container = '#733332'
theme.color.on_primary_container = '#FFDAD8'
theme.color.secondary = '#E7BDBA'
theme.color.on_secondary = '#442928'
theme.color.secondary_container = '#5D3F3E'
theme.color.on_secondary_container = '#FFDAD8'
theme.color.tertiary = '#E3C28C'
theme.color.on_tertiary = '#412D05'
theme.color.tertiary_container = '#5A4319'
theme.color.on_tertiary_container = '#FFDEAA'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#A08C8B'
theme.color.background = '#1A1111'
theme.color.on_background = '#F0DEDD'
theme.color.surface = '#1A1111'
theme.color.on_surface = '#F0DEDD'
theme.color.surface_variant = '#534342'
theme.color.on_surface_variant = '#D7C1C0'
theme.color.inverse_surface = '#F0DEDD'
theme.color.inverse_on_surface = '#382E2D'
theme.color.inverse_primary = '#904A48'
theme.color.surface_tint_color = '#FFB3B0'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'
theme.color.surface_container = '#271D1D'
theme.color.outline_variant = '#534342'
theme.color.surface_container_low = '#231919'
theme.color.surface_container_high = '#322827'

return theme
