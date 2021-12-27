local spawn = require("awful.spawn")

local app = {}

function app.start(cmd, is_shell, have_class, callback)
  local is_shell = is_shell or nil -- bool
  local have_class = have_class or nil -- string
  spawn(cmd)
  if callback then callback() end
end

function app.shell(cmd)
  spawn.with_shell(terminal .. " -e " .. cmd)
end

function app.web(link)
  spawn(web_browser .. " " .. link)
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

return app
