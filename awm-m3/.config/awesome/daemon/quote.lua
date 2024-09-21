local awful = require("awful")
local helpers = require("lib.helpers")

local update_interval = 1200
local temp_file = "/tmp/awm-quotes"

local script = [[sh -c '
 thequote=$(curl -s https://zenquotes.io/api/random)

 [ -z "$thequote] && {
   echo "..."
   exit 1
 }

 quote=$(echo "$thequote" | jq '.[0].q')
 author=$(echo "$thequote" | jq '.[0].a')

 echo "$quote@@$author"
']]

helpers.remote_watch(script, update_interval, temp_file, function(stdout)
  if stdout ~= '...' then
    local quote = stdout:match('(.*)@@')
    local author = stdout:match('@@(.*)')
    awesome.emit_signal("daemon::quote", quote, author)
  else
    awful.spawn.with_shell("rm "..temp_file)
  end
end)
