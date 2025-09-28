local awful = require('awful')

-- Keyboard map indicator and switcher
local keyboard = class()

function keyboard:init()
  return awful.widget.keyboardlayout()
end

return keyboard
