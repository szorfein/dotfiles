local theme = {
  name = 'miami',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'miami.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#ffb3ad'
theme.color.on_primary = '#66040e'
theme.color.primary_container = '#871f22'
theme.color.on_primary_container = '#ffdad6'
theme.color.secondary = '#e7bdba'
theme.color.on_secondary = '#442a28'
theme.color.secondary_container = '#5d3f3d'
theme.color.on_secondary_container = '#ffdad7'
theme.color.tertiary = '#e2c28c'
theme.color.on_tertiary = '#402d05'
theme.color.tertiary_container = '#594319'
theme.color.on_tertiary_container = '#ffdea7'
theme.color.error = '#ffb4a9'
theme.color.on_error = '#680003'
theme.color.error_container = '#930006'
theme.color.on_error_container = '#ffdad4'
theme.color.outline = '#9f8c8a'
theme.color.background = '#1e1f24'
theme.color.on_background = '#f3f4fb'
theme.color.surface = '#1e1f24'
theme.color.on_surface = '#f3f4fb'
theme.color.surface_variant = '#524342'
theme.color.on_surface_variant = '#d8c2c0'
theme.color.inverse_surface = '#ecdfde'
theme.color.inverse_on_surface = '#201a1a'
theme.color.inverse_primary = '#a83737'
theme.color.surface_tint_color = '#ffb3ad'
theme.color.shadow = '#000000'

theme.typescale.display_large = { font = 'SpaceMono Nerd Font Bold', size = 48 }
theme.typescale.display_medium = { font = 'SpaceMono Nerd Font Regular', size = 44 }
theme.typescale.display_small = { font = 'SpaceMono Nerd Font Regular', size = 36 }
theme.typescale.headline_large = { font = 'SpaceMono Nerd Font Bold', size = 30 }
theme.typescale.headline_medium = { font = 'SpaceMono Nerd Font Regular', size = 28 }
theme.typescale.headline_small = { font = 'SpaceMono Nerd Font Regular', size = 24 }
theme.typescale.title_large = { font = 'SpaceMono Nerd Font Regular', size = 22 }
theme.typescale.title_medium = { font = 'SpaceMono Nerd Font Monoum', size = 15 }
theme.typescale.title_small = { font = 'SpaceMono Nerd Font Medium', size = 14 }
theme.typescale.body_large = { font = 'SpaceMono Nerd Font Regular', size = 16 }
theme.typescale.body_medium = { font = 'SpaceMono Nerd Font Mono Regular', size = 12 }
theme.typescale.body_small = { font = 'SpaceMono Nerd Font Regular', size = 11 }
theme.typescale.label_large = { font = 'SpaceMono Nerd Font Mono Regular', size = 14 }
theme.typescale.label_medium = { font = 'SpaceMono Nerd Font Mono Regular', size = 12 }
theme.typescale.label_small = { font = 'SpaceMono Nerd Font Medium', size = 11 }
theme.typescale.icon = { font = 'Material Design Icons Desktop Regular', size = 14 }

return theme

