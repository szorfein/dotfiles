local spawn = require('awful.spawn')

local app = {}

function app:lock()
  spawn.with_shell([[ sh -c '
  i3lock -k -f -e \
    --color=]]..md.sys.color.background..[[ \
    --ring-color=]]..md.sys.color.primary..md.sys.elevation.level1..[[ \
    --inside-color=]]..md.sys.color.background..[[ \
    --ringver-color=]]..md.sys.color.secondary..[[ \
    --insidever-color=]]..md.sys.color.primary..md.sys.elevation.level1..[[ \
    --ringwrong-color=]]..md.sys.color.error..[[ \
    --insidewrong-color=]]..md.sys.color.primary..md.sys.elevation.level1..[[ \
    --line-color=]]..md.sys.color.secondary..[[ \
    --keyhl-color=]]..md.sys.color.primary..[[ \
    --bshl-color=]]..md.sys.color.error..[[ \
    --ringwrong-color=]]..md.sys.color.error..[[ \
    --insidewrong-color=]]..md.sys.color.surface..[[ \
    --layout-color=]]..md.sys.color.on_background..[[ \
    --time-color=]]..md.sys.color.on_background..[[ \
    --date-color=]]..md.sys.color.on_background..[[ \
    --greeter-color=]]..md.sys.color.on_background..[[ \
    --verif-color=]]..md.sys.color.on_background..[[ \
    --wrong-color=]]..md.sys.color.on_background..[[ \
    --modif-color=]]..md.sys.color.on_background..[[ \
    --time-font=]]..md.sys.typescale.title_large.font..[[ \
    --time-size=]]..md.sys.typescale.title_large.size..[[ \
    --date-font=]]..md.sys.typescale.title_medium.font..[[ \
    --date-size=]]..md.sys.typescale.title_medium.size..[[ \
    --time-str="%H:%M"
  ']])
end

return app
