local helpers = require("helpers")
local beautiful = require("beautiful")
local gtimer = require("gears.timer")
local noti = require("utils.noti")
local spawn = require("awful.spawn")

local unknown_icon = beautiful.widget_battery_icon_unknown or ""
local discharging_icon = beautiful.widget_battery_icon_discharging or ""
local charging_icon = beautiful.widget_battery_icon_charging or ""
local full_icon = beautiful.widget_battery_icon_full or ""
local ac_icon = beautiful.widget_battery_icon_ac or "臘"

local battery_state = {
  ["Full"]        = { full_icon, M.x.primary },
  ["Unknown"]     = { unknown_icon, M.x.error },
  ["Charged"]     = { charging_icon, M.x.primary_variant_1 },
  ["Charging"]    = { charging_icon, M.x.secondary },
  ["Discharging"] = { discharging_icon, M.x.error_variant_1 },
}

local state_old = "Full"
local start = true
local update_interval = 15

local function battery_info()
  spawn.easy_async_with_shell(
    "sh -c 'out=\"$(find /sys/class/power_supply/BAT?)\" && (echo \"$out\" | head -n 1) || false' ", 
    function(battery_file, _, __, exit_code)

      if not (exit_code == 0) then
        noti.info("No battery found")
        return
      end

      local fpath = battery_file:gsub('%\n', '')

      -- if battery is present
      local bat_script = [[ sh -c '
        path="]]..fpath..[["
        present="$(cat $path/present)"
        stat="$(cat $path/status)"
        charge_now="$(cat $path/charge_now)"
        [ -f "$path/energy_now" ] && charge_now="$(cat $path/energy_now)"
        charge_full="$(cat $path/charge_full)"
        [ -f "$path/energy_full" ] && charge_full="$(cat $path/energy_full)"
        echo "$present@$stat@$charge_now@$charge_full@"
      '
      ]]

      spawn.easy_async_with_shell(bat_script, function(stdout)
        if (stdout == nil or stdout == '') then
          noti.info("Failed to retrieve info about your battery")
          return awesome.emit_signal("daemon::battery", battery_state["Unknown\n"], 0)
        end

        local present, stat, charge_now, charge_full = stdout:match('(.-)@(.-)@(.-)@(.-)@')
        local bat = fpath:match('(BAT[0-9])')

        if not present or present ~= "1" then
          return awesome.emit_signal("daemon::battery", battery_state["Unknown\n"], 0)
        end

        -- notif if state change
        if stat ~= state_old and not start then
          noti.info(bat:lower() .. " " .. stat:lower())
          state_old = stat
        end

        -- state information
        local state = battery_state[stat] or battery_state["Unknown\n"]

        -- charge now
        local remaining, capacity, capacity_design
        if charge_now then
          capacity = charge_full
          remaining = charge_now
          capacity_design = capacity
        else
          return awesome.emit_signal("daemon::battery", battery_state["Unknown\n"], 0)
        end

        local percent = math.min(math.floor(remaining / capacity * 100), 100)

        awesome.emit_signal("daemon::battery", stat, percent, bat)
        start = false
      end)
  end)
end

-- update every 10 seconds
gtimer {
  timeout = update_interval, autostart = true, call_now = true,
  callback = function() battery_info() end
}
