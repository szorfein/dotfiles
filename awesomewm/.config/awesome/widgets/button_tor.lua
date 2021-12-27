local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local icons = require("icons.default")
local button = require("utils.button")
local font = require("util.font")
local ufont = require("utils.font")

-- beautiful vars
local tor_icon = beautiful.widget_tor_icon or ""
local fg_enable = beautiful.widget_tor_fg_enable or M.x.primary
local fg_disable = beautiful.widget_tor_fg_disable or M.x.error
local padding = beautiful.widget_popup_padding or dpi(1)

-- widget creation
local tor_widget = button({
  fg_icon = M.x.primary,
  icon = ufont.icon(tor_icon)
})
local tor_run = nil -- boolean
local sep = font.caption("")
sep.markup = helpers.colorize_text("---", M.x.on_surface, M.t.disabled)

-- popup
local popup_image = widget.imagebox(80)

-- button (to use the systemd service) (restart tor change your ip address)
local little_size = 18

local button_start = widget.imagebox(little_size, icons["tor_start"])
widget.add_left_click_action(button_start, "sudo systemctl start tor", true, 'miniterm')

local button_stop = widget.imagebox(little_size, icons["tor_stop"])
widget.add_left_click_action(button_stop, "sudo systemctl stop tor", true, 'miniterm')

local button_restart = widget.imagebox(little_size, icons["tor_restart"])
widget.add_left_click_action(button_restart, "sudo systemctl restart tor", true, 'miniterm')

-- To display informations about your ip
local popup_ip = font.body_text("")
local popup_region = font.body_text("")
local popup_country = font.body_text("")
local popup_hostname = font.body_text("")
local w = awful.popup {
  widget = {
    {
      {
        nil,
        popup_image,
        expand = "none",
        layout = wibox.layout.align.vertical
      },
      {
        {
          {
            {
              popup_ip,
              popup_region,
              popup_country,
              popup_hostname,
              layout = wibox.layout.fixed.vertical
            },
            margins = 10,
            widget = wibox.container.margin
          },
          bg = M.x.surface,
          widget = wibox.container.background
        },
        {
          {
            widget.centered(button_start),
            sep,
            widget.centered(button_stop),
            sep,
            widget.centered(button_restart),
            layout = wibox.layout.fixed.vertical
          },
          top = 3,
          left = 6,
          right = 3,
          widget = wibox.container.margin
        },
        layout = wibox.layout.align.horizontal
      },
      layout = wibox.layout.align.horizontal
    },
    margins = 10,
    widget = wibox.container.margin
  },
  visible = false,
  ontop = true,
  hide_on_right_click = true,
  offset = { y = padding, x = padding },
  bg = M.x.surface
}

-- attach popup
w:bind_to_widget(tor_widget)

local tor_is_working_script = [[
  bash -c "
  ~/.config/awesome/widgets/tor.sh check
"]]

awful.widget.watch(tor_is_working_script, 20,
function(widget, stdout, stderr, exitreason, exitcode)
  local code = tonumber(stdout) or 1
  if (code == 0) then
    tor_run = true
    popup_image.image = icons["tor_on"]
  else
    tor_run = false
    popup_image.image = icons["tor_off"]
  end
end)

local tor_infos_script = [[
  bash -c "
  ~/.config/awesome/widgets/tor.sh ip
"]]

local function update_popup() 
  awful.widget.watch(tor_infos_script, 180, function(widget, stdout)
    local ip, city, region, country, hostname = stdout:match('"(.*)"%s*"(.*)"%s*"(.*)"%s*"(.*)"%s*"(.*)"')
    local msg

    if tor_run == true then
      msg = 'Rate limit exceeded.'
    else
      msg = 'TOR is not running.'
    end

    ip = ip or msg
    city = city or msg
    country = country or msg
    hostname = hostname or msg

    popup_ip.markup = helpers.colorize_text("ip: "..ip, M.x.error)
    popup_region.markup = helpers.colorize_text("city: "..city, "#f0f000")
    popup_country.markup = helpers.colorize_text("country: "..country, "#f000f0")
    popup_hostname.markup = helpers.colorize_text("hostname: "..hostname, "#00f000")
  end
  )
end

update_popup()

return tor_widget
