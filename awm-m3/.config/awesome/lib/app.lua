local spawn = require('awful.spawn')

local app = {}

function app:lock()
  spawn.with_shell([[
  betterlockscreen -l
  ]])
end

function app:lock_with_xss()
  spawn.with_shell([[
  xss-lock --transfer-sleep-lock -- \
  betterlockscreen -l
  ]])
end

return app
