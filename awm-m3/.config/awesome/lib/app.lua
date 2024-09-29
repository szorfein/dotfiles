local spawn = require('awful.spawn')
local snackbar = require('lib.snackbar')
local user = require('config.user')

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

--function app:web(link)
--  spawn.with_shell(web_browser .. link)
--end
function app:launch(script)
  spawn.easy_async_with_shell(script, function(stdout, stderr, _, exit_code)
    if exit_code ~= 0 then
      snackbar.debug({ text = 'err with ' .. stderr .. ' - ' .. stdout })
    end
  end)
end

function app:web(str)
  self:launch(user.web .. ' ' .. str)
end

function app:shell(cmd)
  self:launch(user.terminal .. ' ' .. cmd)
end

return app
