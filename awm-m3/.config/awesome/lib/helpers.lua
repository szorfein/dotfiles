local awful = require('awful')
local gears = require('gears')

local helpers = {}

function helpers:rrect(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

function helpers:circle()
  return function(cr, width, height)
    gears.shape.circle(cr, width, height)
  end
end

function helpers:file_exist(file)
  local f = io.open(file, 'r')
  if f then
    f:close()
    return true
  end
  return false
end

function helpers:remote_watch(command, interval, output_file, callback)

  local run_the_thing = function()
    -- Pass output to callback AND write it to file
    awful.spawn.easy_async_with_shell(command.." | tee "..output_file, function(out) callback(out) end)
  end

  local timer
  timer = gears.timer {
    timeout = interval,
    call_now = true,
    autostart = true,
    single_shot = false,
    callback = function()
      awful.spawn.easy_async_with_shell("date -r "..output_file.." +%s", function(last_update, _, __, exitcode)
        if exitcode == 1 then
          run_the_thing()
          return
        end

        local diff = os.time() - tonumber(last_update)
        if diff >= interval then
          run_the_thing()
        else
          awful.spawn.easy_async_with_shell("cat "..output_file, function(out) callback(out) end)
          timer:stop()
          gears.timer.start_new(interval - diff, function()
            run_the_thing()
            timer:again()
          end)
        end
      end)
    end
  }
end

function helpers.pathtotable(dir)
  return setmetatable(
    { _path = dir },
    { __index = function(self, index)
      local path = self._path .. '/' .. index
      local f = io.open(path)
      if f then
        local s = f:read("*all")
        f:close()
        if s then
          return s
        else
          local o = { _path = path }
          setmetatable(o, getmetatable(self))
          return o
        end
      end
    end
  })
end

return helpers
