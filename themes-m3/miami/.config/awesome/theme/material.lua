local theme = {
  name = 'miami',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'miami.jpg',
  color = {},
  typescale = {}
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

theme.typescale.display_large = { font = 'Iosevka Light', size = 54 }
theme.typescale.display_medium = { font = 'Iosevka Regular', size = 44 }
theme.typescale.display_small = { font = 'Iosevka Regular', size = 36 }
theme.typescale.headline_large = { font = 'Iosevka Heavy', size = 35 }
theme.typescale.headline_medium = { font = 'Iosevka Regular', size = 28 }
theme.typescale.headline_small = { font = 'Iosevka Regular', size = 24 }
theme.typescale.title_large = { font = 'Iosevka Regular', size = 22 }
theme.typescale.title_medium = { font = 'Iosevka Medium', size = 15 }
theme.typescale.title_small = { font = 'Iosevka Medium', size = 14 }
theme.typescale.body_large = { font = 'Iosevka Regular', size = 16 }
theme.typescale.body_medium = { font = 'Iosevka Regular', size = 13 }
theme.typescale.body_small = { font = 'Iosevka Regular', size = 12 }
theme.typescale.label_large = { font = 'Iosevka Medium', size = 14 }
theme.typescale.label_medium = { font = 'Iosevka Medium', size = 12 }
theme.typescale.label_small = { font = 'Iosevka Medium', size = 11 }
theme.typescale.icon = { font = 'Material Design Icons Desktop Regular', size = 14 }

return theme
