local spawn = require('awful.spawn')
local timer = require('gears.timer')
local helpers = require('lib.helpers')

local math = { ceil = math.ceil, floor = math.floor }

local function os_status()
  local system = {
    ['osrelease'] = 'N/A',
    ['entropy']   = 'N/A',
    ['uptime']    = '0',
    ['entropy_p'] = 'N/A',
    ['pkgs'] = 'N/A'
  }

  local kernel = helpers.pathtotable('/proc/sys/kernel')

  for k, _ in pairs(system) do
    if kernel[k] then
      system[k] = string.gsub(kernel[k], "[%s]*$", "")
    end
  end

  if kernel.random then
    -- Linux 2.6 default entropy pool is 4096-bits
    local poolsize = tonumber(kernel.random.poolsize)

    -- Get available entropy and calculate percentage
    system['entropy']   = tonumber(kernel.random.entropy_avail)
    system['entropy_p'] = math.ceil(system['entropy'] * 100 / poolsize)
  end

  -- uptime
  local up_t
  for line in io.lines('/proc/uptime') do
    up_t = math.floor(string.match(line, "[%d]+"))
  end

  local up_h = math.floor((up_t  % (3600 * 24)) / 3600)
  local up_m = math.floor(((up_t % (3600 * 24)) % 3600) / 60)

  system['uptime'] = up_h .. 'H, ' .. up_m .. 'M'

  -- numbers of packages for the end
  local script = [[
  #!/usr/bin/env sh

  set -o errexit

  pkg=0

  if [ -f /usr/bin/xbps-query ] ; then
    pkg=$(xbps-query -l | wc -l)
  fi

  echo "$pkg"
  ]]

  spawn.easy_async_with_shell(script, function(stdout)
    if stdout then
      system['pkgs'] = stdout:match('(%d+)')
    end
    awesome.emit_signal('daemon::os', system['osrelease'],
                                      system['uptime'],
                                      system['pkgs'],
                                      system['entropy'])
  end)
end

timer {
  timeout = 60 * 2, -- 2min
  autostart = true,
  call_now = true,
  callback = function()
    os_status()
  end
}
