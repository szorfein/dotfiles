local awful = require 'awful'
local helpers = require 'lib.helpers'

local update_interval = 60 * 5
local file = '/tmp/awm-quotes'
local script_f = '~/.config/awesome/scripts/quote.sh'

local script = [[ sh -c ']] .. script_f .. [[']]

helpers:remote_watch(script, update_interval, file, function(stdout)
    local quote = stdout:match '(.*)@@'
    local author = stdout:match '@@(.*)'
    if stdout ~= '...' then
        awesome.emit_signal('daemon::quote', quote, author)
    else
        awful.spawn.with_shell('rm ' .. file)
        awesome.emit_signal('daemon::quote', 'none', 'none')
    end
end)
