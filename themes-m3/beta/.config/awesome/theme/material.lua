local theme = {
  name = 'beta',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'beta.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#acc7ff'
theme.color.on_primary = '#002e6c'
theme.color.primary_container = '#004397'
theme.color.on_primary_container = '#d6e2ff'
theme.color.secondary = '#bfc6dc'
theme.color.on_secondary = '#283041'
theme.color.secondary_container = '#3f4759'
theme.color.on_secondary_container = '#dae2f9'
theme.color.tertiary = '#debbdf'
theme.color.on_tertiary = '#402843'
theme.color.tertiary_container = '#583e5b'
theme.color.on_tertiary_container = '#fbd7fb'
theme.color.error = '#ffb4a9'
theme.color.on_error = '#680003'
theme.color.error_container = '#930006'
theme.color.on_error_container = '#ffdad4'
theme.color.outline = '#8e9099'
theme.color.background = '#1b1b1e'
theme.color.on_background = '#e4e2e6'
theme.color.surface = '#1b1b1e'
theme.color.on_surface = '#e4e2e6'
theme.color.surface_variant = '#44474f'
theme.color.on_surface_variant = '#c4c6d0'
theme.color.inverse_surface = '#e4e2e6'
theme.color.inverse_on_surface = '#1b1b1e'
theme.color.inverse_primary = '#005ac5'
theme.color.surface_tint_color = '#acc7ff'
theme.color.shadow = '#000000'

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

