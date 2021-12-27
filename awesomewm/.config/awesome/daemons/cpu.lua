-- function from vicious lib :)
local timer = require("gears.timer")
local io = { lines = io.lines }

-- Initialize function tables
local cpu_usage  = {}
local cpu_total  = {}
local cpu_active = {}

local function cpu_info()
  local cpu_lines = {}

  for line in io.lines("/proc/stat") do
    if string.sub(line, 1, 3) ~= "cpu" then break end

    cpu_lines[#cpu_lines+1] = {}

    for i in string.gmatch(line, "[%s]+([^%s]+)") do
      table.insert(cpu_lines[#cpu_lines], i)
    end
  end

  -- init tables
  for i = #cpu_total + 1, #cpu_lines do
    cpu_total[i]  = 0
    cpu_usage[i]  = 0
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
    local diff_total  = total_new - cpu_total[i]
    local diff_active = active_new - cpu_active[i]

    if diff_total == 0 then diff_total = 1E-6 end

    cpu_usage[i]      = math.floor((diff_active / diff_total) * 100)

    -- Store totals
    cpu_total[i]   = total_new
    cpu_active[i]  = active_new
  end

  --naughty.notify({ text = "call naughty", timeout = 2 })
  awesome.emit_signal("daemon::cpu", cpu_usage)
end

-- update every 6 seconds
timer {
  timeout = 6,
  autostart = true,
  call_now = true,
  callback = function()
    cpu_info()
  end
}
