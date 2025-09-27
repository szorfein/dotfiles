local fonts = require('lib.fonts')

local theme = {
  name = 'lines',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'lines.jpg',
  color = {},
  typescale = fonts.iosevka()
}

theme.color.primary = '#B1C5FF'
theme.color.on_primary = '#162E60'
theme.color.primary_container = '#2F4578'
theme.color.on_primary_container = '#DAE2FF'
theme.color.secondary = '#D1BCFD'
theme.color.on_secondary = '#37265C'
theme.color.secondary_container = '#4E3D75'
theme.color.on_secondary_container = '#EADDFF'
theme.color.tertiary = '#F3B2E4'
theme.color.on_tertiary = '#4D1F47'
theme.color.tertiary_container = '#67355E'
theme.color.on_tertiary_container = '#FFD7F3'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#8F9099'
theme.color.background = '#121318'
theme.color.on_background = '#E2E2E9'
theme.color.surface = '#121318'
theme.color.on_surface = '#E2E2E9'
theme.color.surface_variant = '#44464F'
theme.color.on_surface_variant = '#C5C6D0'
theme.color.inverse_surface = '#E2E2E9'
theme.color.inverse_on_surface = '#2F3036'
theme.color.inverse_primary = '#485D92'
theme.color.surface_tint_color = '#B1C5FF'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'
theme.color.surface_container = '#1E1F25'
theme.color.outline_variant = '#44464F'
theme.color.surface_container_low = '#1A1B21'
theme.color.surface_container_high = '#282A2F'

return theme
