local theme = {
  name = 'morpho',
  wallpaper = os.getenv('HOME') .. '/images/' .. 'morpho.jpg',
  color = {},
  typescale = {}
}

theme.color.primary = '#CDBDFF'
theme.color.on_primary = '#361387'
theme.color.primary_container = '#644AB6'
theme.color.on_primary_container = '#FFFFFF'
theme.color.secondary = '#CCBFF1'
theme.color.on_secondary = '#332A52'
theme.color.secondary_container = '#433A63'
theme.color.on_secondary_container = '#DBCEFF'
theme.color.tertiary = '#FFADE2'
theme.color.on_tertiary = '#5F004E'
theme.color.tertiary_container = '#97387F'
theme.color.on_tertiary_container = '#FFFFFF'
theme.color.error = '#FFB4AB'
theme.color.on_error = '#690005'
theme.color.error_container = '#93000A'
theme.color.on_error_container = '#FFDAD6'
theme.color.outline = '#948E9E'
theme.color.background = '#141219'
theme.color.on_background = '#E6E0EA'
theme.color.surface = '#141219'
theme.color.on_surface = '#E6E0EA'
theme.color.surface_variant = '#494552'
theme.color.on_surface_variant = '#CAC4D4'
theme.color.inverse_surface = '#E6E0EA'
theme.color.inverse_on_surface = '#322F37'
theme.color.inverse_primary = '#654BB8'
theme.color.surface_tint_color = '#CDBDFF'
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
