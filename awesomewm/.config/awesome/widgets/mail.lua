local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local font = require("util.font")
local tooltip = require("utils.tooltip")
local font = require("util.font")

-- beautiful vars
local fg_read = beautiful.widget_email_fg_read or M.x.on_background
local fg_unread = beautiful.widget_email_fg_unread or M.x.on_background
local bg = beautiful.widget_email_bg or M.x.background
local l = beautiful.widget_email_layout or 'horizontal'
local w_type = beautiful.widget_email_type or 'text'
local padding = beautiful.widget_popup_padding or 1
local spacing = beautiful.widget_spacing or 1
local read_icon = beautiful.widget_email_read_icon or ""
local unread_icon = beautiful.widget_email_unread_icon or ""

-- widget creation
local icon = font.button(unread_icon, fg_unread, M.t.medium)
local text = font.button("")
local email_widget = widget.box(l, { icon, text }, spacing)

local popup_title = font.h6("Last messages:", M.x.on_surface)
local popup_msg = {}
for i = 1, 4 do
  popup_msg[i] = font.body_text("")
end

local w = awful.popup {
  widget = {
    {
      layout = wibox.layout.align.horizontal
    },
    {
      {
        {
          popup_title,
          popup_msg[1],
          popup_msg[2],
          popup_msg[3],
          popup_msg[4],
          layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.align.horizontal
      },
      margins = 10,
      widget = wibox.container.margin
    },
    {
      layout = wibox.layout.align.horizontal
    },
    layout = wibox.layout.fixed.horizontal
  },
  visible = false,
  ontop = true,
  hide_on_right_click = true,
  offset = { y = padding, x = padding },
  bg = M.x.surface
}

w:bind_to_widget(email_widget)

-- tooltip
local tt = tooltip.create(email_widget)

local grab_emails_script = [[
  bash -c "
  ~/.config/awesome/widgets/email.sh get ~/.mails
"]]

awful.widget.watch(grab_emails_script, 300, -- 5m
  function(widget, stdout, stderr, exitreason, exitcode)
    local filter_mail = stdout:match('%d+') or 0
    local mail_num = tonumber(filter_mail) or 0
    if (mail_num > 0) then
      icon.markup = helpers.colorize_text(read_icon, fg_read, M.t.high)
      text.markup = helpers.colorize_text(mail_num, fg_read, M.t.high)
      tt.text = "You got "..mail_num.." messages"
    else
      icon.markup = helpers.colorize_text(unread_icon, fg_unread, M.t.disabled)
      text.markup = helpers.colorize_text(0, fg_read, M.t.medium)
      tt.text = "No new messages"
    end
  end
)

local show_emails_script = [[
  bash -c "
  ~/.config/awesome/widgets/email.sh show ~/.mails
"]]

local function update_popup()
  awful.widget.watch(show_emails_script, 60, function(widget, stdout)
    local msg = {}
    msg[1], msg[2], msg[3], msg[4] = stdout:match('[|]*([%s%w@."]*)[|]*([%s%w@."]*)[|]*([%s%w@."]*)[|]*([%s%w@."]*)')

    for i = 1, 4 do
      msg[i] = tostring(msg[i]) or nil
      if msg[i] ~= tostring(nil) and msg[i] ~= '' then
        popup_msg[i].markup = helpers.colorize_text(i.." - From: "..msg[i], M.x.on_surface)
      else
        popup_msg[i].markup = ''
      end
    end

  end)
end

update_popup()

return email_widget
