local gtimer = require("gears.timer")
local noti = require("utils.noti")
local io = { lines = io.lines }

local function mem_info()
  local mem = { buf = {}, swp = {} }

  for line in io.lines("/proc/meminfo") do
    for k, v in string.gmatch(line, "([%a]+):[%s]+([%d]+).+") do
      if     k == "MemTotal"  then mem.total = math.floor(v/1024)
      elseif k == "MemFree"   then mem.buf.f = math.floor(v/1024)
      elseif k == "MemAvailable" then mem.buf.a = math.floor(v/1024)
      elseif k == "Buffers"   then mem.buf.b = math.floor(v/1024)
      elseif k == "Cached"    then mem.buf.c = math.floor(v/1024)
      elseif k == "SwapTotal" then mem.swp.t = math.floor(v/1024)
      elseif k == "SwapFree"  then mem.swp.f = math.floor(v/1024)
      end
    end
  end

  mem.free  = mem.buf.a
  mem.inuse = mem.total - mem.free
  mem.bcuse = mem.total - mem.buf.f
  mem.usep  = math.floor(mem.inuse / mem.total * 100)
  mem.swp.inuse = mem.swp.t - mem.swp.f
  mem.swp.usep  = math.floor(mem.swp.inuse / mem.swp.t * 100)
  mem.inuse_percent = math.floor((mem.total - mem.free) / (mem.total) * 100 + 0.5 )

  if mem.inuse_percent >= 90 then
    local msg = tostring(mem.inuse_percent)
    noti.warn("Memory usage soon full : "..msg.."%")
  end

  awesome.emit_signal("daemon::ram", mem)
end

gtimer {
  timeout = 15, autostart = true, call_now = true,
  callback = function() mem_info() end
}
