local spawn = require('awful.spawn')
local timer = require('gears.timer')
--local snackbar = require('lib.snackbar')

local string = { match = string.match }

local function volume_status()
    spawn.easy_async('amixer get Master', function(stdout)
        if not stdout or stdout == '' then
            awesome.emit_signal('daemon::volume', 0, true)
            return
        end

        local volume, state = string.match(stdout, '%[([%d]+)%%%].*%[([%l]*)%]')

        --snackbar.debug({ title = 'get volume '..volume })
        --snackbar.debug({ title = 'state volume '..state })

        if state == '' and volume == '0' or state == 'off' then
            awesome.emit_signal('daemon::volume', 0, true)
        else
            awesome.emit_signal('daemon::volume', tonumber(volume), false)
        end
    end)
end

timer({
    timeout = 10,
    autostart = true,
    call_now = true,
    callback = function()
        volume_status()
    end,
})
