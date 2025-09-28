local fonts = require('lib.fonts')

local theme = {
  name = 'connected',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'connected.jpg',
  color = {},
  typescale = fonts.iosevka()
}

theme.color.primary = '#A1D1B4'
theme.color.on_primary = '#073823'
theme.color.primary_container = '#3F6C54'
theme.color.on_primary_container = '#FFFFFF'
theme.color.secondary = '#B8CBBD'
theme.color.on_secondary = '#23342A'
theme.color.secondary_container = '#304137'
theme.color.on_secondary_container = '#C3D6C8'
theme.color.tertiary = '#B7C6F0'
theme.color.on_tertiary = '#212F52'
theme.color.tertiary_container = '#556388'
theme.color.on_tertiary_container = '#FFFFFF'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#8B938C'
theme.color.background = '#111412'
theme.color.on_background = '#E2E3DF'
theme.color.surface = '#111412'
theme.color.on_surface = '#E2E3DF'
theme.color.surface_variant = '#414943'
theme.color.on_surface_variant = '#C1C9C1'
theme.color.inverse_surface = '#E2E3DF'
theme.color.inverse_on_surface = '#2E312F'
theme.color.inverse_primary = '#3B674F'
theme.color.surface_tint_color = '#A1D1B4'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'
theme.color.surface_container = '#1E201E'
theme.color.outline_variant = '#414943'
theme.color.surface_container_low = '#1A1C1A'
theme.color.surface_container_high = '#282B28'

return theme
