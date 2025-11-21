local awful = require 'awful'
local helpers = require 'lib.helpers'

local interval = 60 -- 1 min

local file = '/tmp/geoloc'

local script = [[ sh -c '
agent="Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0"
content=$(curl -A "$agent" -sSL https://ipleak.net/json)

country=$(echo "$content" | jq .country_name | tr -d \")
city=$(echo "$content" | jq .city_name | tr -d \")

echo "COUNTRY@$country@CITY@$city@"
']]

helpers:remote_watch(script, interval, file, function(stdout)
    local country = stdout:match '^COUNTRY@(.*)@CITY'
    local city = stdout:match 'CITY@(.*)@'

    if country then
        awesome.emit_signal('daemon::geoloc', country, city)
    else
        awful.spawn.with_shell('rm ' .. file)
        awesome.emit_signal('daemon::geoloc', nil, nil)
    end
end)
