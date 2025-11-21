-- https://github.com/vicious-widgets/vicious/blob/master/widgets/mem_linux.lua

local io = { lines = io.lines }
local math = { floor = math.floor }
local string = { gmatch = string.gmatch }
local timer = require 'gears.timer'

local function mem_status()
    local _mem = { buf = {} }

    -- Get MEM info
    for line in io.lines '/proc/meminfo' do
        for k, v in string.gmatch(line, '([%a]+):[%s]+([%d]+).+') do
            if k == 'MemTotal' then
                _mem.total = math.floor(v / 1024)
            elseif k == 'MemFree' then
                _mem.buf.f = math.floor(v / 1024)
            elseif k == 'MemAvailable' then
                _mem.buf.a = math.floor(v / 1024)
            end
        end
    end

    _mem.free = _mem.buf.a
    _mem.inuse = _mem.total - _mem.free
    _mem.bcuse = _mem.total - _mem.buf.f
    _mem.usep = math.floor(_mem.inuse / _mem.total * 100)

    awesome.emit_signal('daemon::mem', _mem.usep)
end

timer {
    timeout = 10,
    autostart = true,
    call_now = true,
    callback = function()
        mem_status()
    end,
}
