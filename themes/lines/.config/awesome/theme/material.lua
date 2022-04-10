local theme = {
  name = 'lines',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'lines.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#f5adff'
theme.color.on_primary = '#55006d'
theme.color.primary_container = '#790097'
theme.color.on_primary_container = '#fed5ff'
theme.color.secondary = '#d6bfd6'
theme.color.on_secondary = '#3a2b3c'
theme.color.secondary_container = '#524154'
theme.color.on_secondary_container = '#f3dcf2'
theme.color.tertiary = '#f5b7b0'
theme.color.on_tertiary = '#4c2521'
theme.color.tertiary_container = '#673b36'
theme.color.on_tertiary_container = '#ffdad4'
theme.color.error = '#ffb4a9'
theme.color.on_error = '#680003'
theme.color.error_container = '#930006'
theme.color.on_error_container = '#ffdad4'
theme.color.outline = '#988d97'
theme.color.background = '#1e1a1e'
theme.color.on_background = '#e8e0e4'
theme.color.surface = '#1e1a1e'
theme.color.on_surface = '#e8e0e4'
theme.color.surface_variant = '#4d444d'
theme.color.on_surface_variant = '#cfc3cd'
theme.color.inverse_surface = '#e8e0e4'
theme.color.inverse_on_surface = '#1e1a1e'
theme.color.inverse_primary = '#952bb2'
theme.color.surface_tint_color = '#f5adff'
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

