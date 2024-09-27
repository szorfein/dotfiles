local fonts = require('lib.fonts')

local theme = {
  name = 'lines',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'lines.jpg',
  color = {},
  typescale = fonts.iosevka()
}

theme.color.primary = '#E1B8F5'
theme.color.on_primary = '#422255'
theme.color.primary_container = '#5A396D'
theme.color.on_primary_container = '#F4D9FF'
theme.color.secondary = '#F3B2E4'
theme.color.on_secondary = '#4D1F47'
theme.color.secondary_container = '#67355E'
theme.color.on_secondary_container = '#FFD7F3'
theme.color.tertiary = '#FFB693'
theme.color.on_tertiary = '#542104'
theme.color.tertiary_container = '#703717'
theme.color.on_tertiary_container = '#FFDBCC'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#8D9199'
theme.color.background = '#161217'
theme.color.on_background = '#E9E0E7'
theme.color.surface = '#111318'
theme.color.on_surface = '#E1E2E9'
theme.color.surface_variant = '#43474E'
theme.color.on_surface_variant = '#C3C6CF'
theme.color.inverse_surface = '#E1E2E9'
theme.color.inverse_on_surface = '#2E3035'
theme.color.inverse_primary = '#735187'
theme.color.surface_tint_color = '#E1B8F5'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'
theme.color.surface_container = '#1D2024'
theme.color.outline_variant = '#43474E'
theme.color.surface_container_low = '#191C20'

return theme
