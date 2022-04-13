local theme = {
  name = 'morpho',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'morpho.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#dbb9ff'
theme.color.on_primary = '#411b6d'
theme.color.primary_container = '#583485'
theme.color.on_primary_container = '#efdbff'
theme.color.secondary = '#cfc2da'
theme.color.on_secondary = '#362d40'
theme.color.secondary_container = '#4c4357'
theme.color.on_secondary_container = '#ebddf6'
theme.color.tertiary = '#f2b8c1'
theme.color.on_tertiary = '#4b252d'
theme.color.tertiary_container = '#653b43'
theme.color.on_tertiary_container = '#ffd9df'
theme.color.error = '#ffb4a9'
theme.color.on_error = '#680003'
theme.color.error_container = '#930006'
theme.color.on_error_container = '#ffdad4'
theme.color.outline = '#958e99'
theme.color.background = '#0f0c1c'
theme.color.on_background = '#e7e1e6'
theme.color.surface = '#0f0c1c'
theme.color.on_surface = '#e7e1e6'
theme.color.surface_variant = '#4a454e'
theme.color.on_surface_variant = '#ccc4cf'
theme.color.inverse_surface = '#e7e1e6'
theme.color.inverse_on_surface = '#1d1b1e'
theme.color.inverse_primary = '#714d9f'
theme.color.surface_tint_color = '#dbb9ff'
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

