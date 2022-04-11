local theme = {
  name = 'sci',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'sci.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#5bd5fa'
theme.color.on_primary = '#003543'
theme.color.primary_container = '#004e61'
theme.color.on_primary_container = '#b1ebff'
theme.color.secondary = '#b2cad4'
theme.color.on_secondary = '#1d333b'
theme.color.secondary_container = '#344a52'
theme.color.on_secondary_container = '#cee6f0'
theme.color.tertiary = '#c2c4eb'
theme.color.on_tertiary = '#2b2e4d'
theme.color.tertiary_container = '#424465'
theme.color.on_tertiary_container = '#dfe0ff'
theme.color.error = '#ffb4a9'
theme.color.on_error = '#680003'
theme.color.error_container = '#930006'
theme.color.on_error_container = '#ffdad4'
theme.color.outline = '#899296'
theme.color.background = '#191c1d'
theme.color.on_background = '#e1e3e4'
theme.color.surface = '#191c1d'
theme.color.on_surface = '#e1e3e4'
theme.color.surface_variant = '#40484b'
theme.color.on_surface_variant = '#bfc8cc'
theme.color.inverse_surface = '#e1e3e4'
theme.color.inverse_on_surface = '#191c1d'
theme.color.inverse_primary = '#00677f'
theme.color.surface_tint_color = '#5bd5fa'
theme.color.shadow = '#000000'

theme.typescale.display_large = { font = 'Iosevka Regular', size = 56 }
theme.typescale.display_medium = { font = 'Iosevka Regular', size = 44 }
theme.typescale.display_small = { font = 'Iosevka Regular', size = 36 }
theme.typescale.headline_large = { font = 'Iosevka Regular', size = 32 }
theme.typescale.headline_medium = { font = 'Iosevka Regular', size = 28 }
theme.typescale.headline_small = { font = 'Iosevka Regular', size = 24 }
theme.typescale.title_large = { font = 'Iosevka Regular', size = 22 }
theme.typescale.title_medium = { font = 'Iosevka Medium', size = 15 }
theme.typescale.title_small = { font = 'Iosevka Medium', size = 14 }
theme.typescale.body_large = { font = 'Iosevka Regular', size = 16 }
theme.typescale.body_medium = { font = 'Iosevka Regular', size = 14 }
theme.typescale.body_small = { font = 'Iosevka Regular', size = 12 }
theme.typescale.label_large = { font = 'Iosevka Medium', size = 14 }
theme.typescale.label_medium = { font = 'Iosevka Medium', size = 12 }
theme.typescale.label_small = { font = 'Iosevka Medium', size = 11 }
theme.typescale.icon = { font = 'Material Design Icons Desktop Regular', size = 14 }

return theme

