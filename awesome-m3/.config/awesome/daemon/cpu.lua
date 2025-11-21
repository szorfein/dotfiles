-- https://github.com/vicious-widgets/vicious/blob/master/widgets/cpu_linux.lua

local timer = require 'gears.timer'
local io = { lines = io.lines }
local string = {
    sub = string.sub,
    gmatch = string.gmatch,
}

local function cpu_status()
    local cpu_usage = {}
    local cpu_total = {}
    local cpu_active = {}
    local cpu_lines = {}

    for line in io.lines '/proc/stat' do
        if string.sub(line, 1, 3) == 'cpu' then
            cpu_lines[#cpu_lines + 1] = {}

            for i in string.gmatch(line, '[%s]+([^%s]+)') do
                table.insert(cpu_lines[#cpu_lines], i)
            end
        end
    end

    for i = #cpu_total + 1, #cpu_lines do
        cpu_total[i] = 0
        cpu_usage[i] = 0
        cpu_active[i] = 0
    end

    for i, v in ipairs(cpu_lines) do
        -- Calculate totals
        local total_new = 0
        for j = 1, #v do
            total_new = total_new + v[j]
        end
        local active_new = total_new - (v[4] + v[5])

        -- Calculate percentage
        local diff_total = total_new - cpu_total[i]
        local diff_active = active_new - cpu_active[i]

        if diff_total == 0 then
            diff_total = 1E-6
        end
        cpu_usage[i] = math.floor((diff_active / diff_total) * 100)
    end

    -- only the 1st value for now
    awesome.emit_signal('daemon::cpu', cpu_usage[1])
end

timer {
    timeout = 10,
    autostart = true,
    call_now = true,
    callback = function()
        cpu_status()
    end,
}
