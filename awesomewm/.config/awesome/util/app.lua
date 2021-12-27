local spawn = require("awful.spawn")
local ascreen = require("awful.screen")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local app = {}

function app.start(cmd, is_shell, have_class, callback)
  local is_shell = is_shell or nil -- bool
  local have_class = have_class or nil -- string
  if is_shell then
    if have_class then
      spawn.with_shell(terminal .. terminal_args[1] .. have_class .. terminal_args[2] .. cmd .. ' 2> /dev/null')
    else
      spawn.with_shell(terminal_cmd .. cmd .. ' 2> /dev/null')
    end
  else
    spawn(cmd)
  end
  if callback then callback() end
end

function app.term_with_class(cmd, class)
  spawn.with_shell(terminal .. terminal_args[1] .. have_class .. terminal_args[2] .. cmd .. ' 2> /dev/null')
end

function app.shell_and_wait(cmd, callback)
  spawn(terminal .. terminal_args[2] .. "bash -c \"".. cmd .. " && read -p 'Press q to quit. ' -n 1\"")
  if callback then callback() end
end

local function check_proc(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then findme = cmd:sub(0, firstspace -1) end
    local command = string.format('pgrep -u $USER -x %s > /dev/null || pgrep -u $USER -x -f %s > /dev/null || echo start', findme, findme)
    local f = io.popen(command)
    local o = f:read('*a')
    f:close()
    if o:match('start') then return 0 else return end
  end
end

function app.run_once(cmd, ...)
  if cmd == nil then return end
  local ret = check_proc(cmd)
  if ret ~= nil then
    app.start(cmd[1], ...)
  end
end

function app.feh(path, callback_function)
  local screen = ascreen.focused().geometry
  local s_width = screen.width / 2
  local s_height = screen.height / 2
  local cmd = "feh --scale-down --auto-zoom --image-bg \""..M.x.surface.."\" "..path.." -g "..s_width.."x"..s_height
  spawn.with_shell(cmd)
  if callback_function ~= nil then
    callback_function()
  end
end

function app.open_link(link, callback)
  spawn(web_browser .. " " .. tostring(link))
  if callback then callback() end
end

return app
