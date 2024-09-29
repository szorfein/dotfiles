
local fonts = {}

function fonts.iosevka()
  local typescale = {
    display_large = { font = 'Iosevka Light', size = 54 },
    display_medium = { font = 'Iosevka Regular', size = 44 },
    display_small = { font = 'Iosevka Regular', size = 36 },
    headline_large = { font = 'Iosevka Heavy', size = 35 },
    headline_medium = { font = 'Iosevka Regular', size = 28 },
    headline_small = { font = 'Iosevka Regular', size = 24 },
    title_large = { font = 'Iosevka Regular', size = 22 },
    title_medium = { font = 'Iosevka Medium', size = 15 },
    title_small = { font = 'Iosevka Medium', size = 14 },
    body_large = { font = 'Iosevka Regular', size = 16 },
    body_medium = { font = 'Iosevka Regular', size = 13 },
    body_small = { font = 'Iosevka Regular', size = 12 },
    label_large = { font = 'Iosevka Medium', size = 14 },
    label_medium = { font = 'Iosevka Medium', size = 12 },
    label_small = { font = 'Iosevka Medium', size = 11 },
    icon = { font = 'Material Design Icons Desktop Regular', size = 14 }
  }

  return typescale
end

return fonts
