local fonts = require('lib.fonts')

local theme = {
  name = 'sci',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'sci.jpg',
  color = {},
  typescale = fonts.iosevka()
}

theme.color.primary = '#70D4ED'
theme.color.on_primary = '#003640'
theme.color.primary_container = '#008095'
theme.color.on_primary_container = '#FFFFFF'
theme.color.secondary = '#A8CCD7'
theme.color.on_secondary = '#0F353D'
theme.color.secondary_container = '#21444D'
theme.color.on_secondary_container = '#B6DAE4'
theme.color.tertiary = '#E6B4FE'
theme.color.on_tertiary = '#461E5D'
theme.color.tertiary_container = '#8F63A7'
theme.color.on_tertiary_container = '#FFFFFF'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#879396'
theme.color.background = '#0F1416'
theme.color.on_background = '#DFE3E5'
theme.color.surface = '#0F1416'
theme.color.on_surface = '#DFE3E5'
theme.color.surface_variant = '#3E494C'
theme.color.on_surface_variant = '#BDC8CC'
theme.color.inverse_surface = '#DFE3E5'
theme.color.inverse_on_surface = '#2C3133'
theme.color.inverse_primary = '#006879'
theme.color.surface_tint_color = '#70D4ED'
theme.color.shadow = '#000000'
theme.color.scrim = '#000000'
theme.color.surface_container = '#1C2022'
theme.color.outline_variant = '#3E494C'
theme.color.surface_container_low = '#181C1E'
theme.color.surface_container_high = '#262B2C'

return theme
