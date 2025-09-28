-- custom function from vicious lib
-- original code: https://github.com/vicious-widgets/vicious/blob/master/widgets/net_linux.lua
local gtimer = require("gears.timer")

local nets = {}
local unit = 1 -- i use only by byte for now

local function network_info()
  local args = {}

  for line in io.lines("/proc/net/dev") do
    local name = string.match(line, "^[%s]?[%s]?[%s]?[%s]?([%w]+):")

    if name ~= nil then
      args[name] = {}

      args[name].name = name

      local recv = tonumber(string.match(line, ":[%s]*([%d]+)"))
      local send = tonumber(string.match(line, "([%d]+)%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+%d$"))

      args[name].rx = string.format("%.1f", recv/unit)
      args[name].tx = string.format("%.1f", send/unit)

      -- state carrier detection
      local carrierpath = "/sys/class/net/"..name.."/carrier"
      local f = io.open(carrierpath, 'r') 
      args[name].carrier = f:read('*a') or 0
      f:close()

      -- store ip if carrier is found
      local cmd = "ip a | grep "..name.." | grep inet | awk '{print $2}' | sed 's:/.[0-9]*::'"
      local output = assert(io.popen(cmd, 'r'))
      local ip = assert(output:read('*a')) or tostring(nil)
      output:close()
      args[name].ip = args[name].carrier == 0 or ip:match('([0-9]+.[0-9]+.[0-9]+.[0-9]+)')

      local now = os.time()
      if nets[name] == nil then -- first call, default value
        nets[name] = {}
        args[name]["down"] = 0
        args[name]["up"] = 0
      else
        local interval = now - nets[name].time
        if interval <= 0 then interval = 1 end

        local down = (recv - nets[name][1]) / interval
        local up   = (send - nets[name][2]) / interval

        args[name].down = string.format("%.1f", down/unit)
        args[name].up = string.format("%.1f", up/unit)
      end
      nets[name].time = now

      -- store total
      nets[name][1] = recv
      nets[name][2] = send
    end
  end

  awesome.emit_signal("daemon::network", args)
end

gtimer {
  timeout = 5, autostart = true, call_now = true,
  callback = function() network_info() end
}
