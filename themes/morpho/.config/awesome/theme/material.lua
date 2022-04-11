local theme = {
  name = 'morpho',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'morpho.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#d0bcff'
theme.color.on_primary = '#381e72'
theme.color.primary_container = '#4f378b'
theme.color.on_primary_container = '#eaddff'
theme.color.secondary = '#ccc2dc'
theme.color.on_secondary = '#332d41'
theme.color.secondary_container = '#4a4458'
theme.color.on_secondary_container = '#e8def8'
theme.color.tertiary = '#efb8c8'
theme.color.on_tertiary = '#492532'
theme.color.tertiary_container = '#633b48'
theme.color.on_tertiary_container = '#ffd8e4'
theme.color.error = '#f2b8b5'
theme.color.on_error = '#601410'
theme.color.error_container = '#8c1d18'
theme.color.on_error_container = '#f2b8b5'
theme.color.outline = '#938f99'
theme.color.background = '#0c0a18'
theme.color.on_background = '#eceafa'
theme.color.surface = '#0c0a18'
theme.color.on_surface = '#eceafa'
theme.color.surface_variant = '#49454f'
theme.color.on_surface_variant = '#cac4d0'
theme.color.inverse_surface = '#e6e1e5'
theme.color.inverse_on_surface = '#313033'
theme.color.inverse_primary = '#6750a4'
theme.color.surface_tint_color = '#d0bcff'
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

