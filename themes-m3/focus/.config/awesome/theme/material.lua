local fonts = require('lib.fonts')

local theme = {
  name = 'focus',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'focus.png',
  color = {},
  typescale = fonts.iosevka()
}

theme.color.primary = '#DAB9FE'
theme.color.on_primary = '#3E235D'
theme.color.primary_container = '#472C66'
theme.color.on_primary_container = '#DDBEFF'
theme.color.secondary = '#FFAFD4'
theme.color.on_secondary = '#620040'
theme.color.secondary_container = '#7F0E55'
theme.color.on_secondary_container = '#FFCBE0'
theme.color.tertiary = '#FFB2B6'
theme.color.on_tertiary = '#67001A'
theme.color.tertiary_container = '#E80047'
theme.color.on_tertiary_container = '#FFFFFF'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#988E90'
theme.color.background = '#151217'
theme.color.on_background = '#E7E0E6'
theme.color.surface = '#131313'
theme.color.on_surface = '#E2E2E2'
theme.color.surface_variant = '#4C4546'
theme.color.on_surface_variant = '#CFC4C5'
theme.color.inverse_surface = '#E2E2E2'
theme.color.inverse_on_surface = '#303030'
theme.color.inverse_primary = '#6E528F'
theme.color.surface_tint_color = '#DAB9FE'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'
theme.color.surface_container = '#1F1F1F'
theme.color.outline_variant = '#4C4546'
theme.color.surface_container_low = '#1B1B1B'
theme.color.surface_container_high = '#272A2F'

return theme
