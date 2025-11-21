local spawn = require 'awful.spawn'
local timer = require 'gears.timer'

local script = [[ sh -c '
LC_ALL=C df -kP /
']]

local function disk_status()
    spawn.easy_async_with_shell(script, function(stdout)
        -- (1024-blocks) (Used) (Available) (Capacity)% (Mounted on)
        local s, u, a, p, m = stdout:match '^.-%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%%%s+([%p%w]+)'
        local used = tonumber(p)

        awesome.emit_signal('daemon::disk', used)
    end)
end

timer {
    timeout = 60 * 3, -- all the 3 mins
    autostart = true,
    call_now = true,
    callback = function()
        disk_status()
    end,
}
