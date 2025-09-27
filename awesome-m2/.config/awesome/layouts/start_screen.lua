local wibox = require("wibox")
local gtable = require("gears.table")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local helper = require("utils.helper")
local app = require("util.app")
local modal = require("utils.modal")
local button = require("utils.button")
local ufont = require("utils.font")
local mat_text = require("utils.material.text")
local icons = require("config.icons")
local io = {
  open = io.open,
  lines = io.lines
}

local function start_screen_hide()
  local s = awful.screen.focused()
  s.start_screen.visible = false
end

local exec_prog = function(cmd)
  app.start(cmd, nil, nil, start_screen_hide)
end

local function open_link(url)
  app.open_link(url, start_screen_hide)
end

local max_feeds = 6
local feed_width = 370
local feed_height = 320
local todo_width = feed_width
local todo_height = 250

-- base for rss
local rss_threatpost = wibox.widget {
  spacing = 8,
  layout = wibox.layout.fixed.vertical
}

local rss_ycombinator = wibox.widget {
  spacing = 8,
  layout = wibox.layout.fixed.vertical
}

local tabs = require("util.tabs")
local rss_widgets = tabs({
  texts = { "ycombinator", "threatpost" }, -- text titles
  containers = { rss_ycombinator, rss_threatpost } -- matching widgets
})

local function rss_links(rss, feed_name, w)
  w:reset()
  local f, s, b
  for i = 1, max_feeds do
    f = function() open_link(rss[feed_name].link[i]) end
    s = string.sub(rss[feed_name].title[i], 1, 26)
    b = button({
      icon = ufont.body_2(s),
      command = f,
      margins = 2,
      width = dpi(310)
    })
    w:add(b)
  end
end

-- signal to update rss feeds
awesome.connect_signal("daemon::rss", function(rss)
  if rss.threatpost then
    rss_links(rss, "threatpost", rss_threatpost)
  end
  if rss.ycombinator then
    rss_links(rss, "ycombinator", rss_ycombinator)
  end
end)

-- images
local theme_picture_container = wibox.container.background()
theme_picture_container.forced_height = dpi(100)
theme_picture_container.forced_width = dpi(160)

local theme_picture = wibox.widget {
  wibox.widget.imagebox(beautiful.wallpaper),
  widget = theme_picture_container
}

local theme_name = wibox.widget {
  ufont.h6(M.name),
  widget = mat_text({ lv = "high" })
}
local picture_widget = widget.box('vertical', { theme_picture, theme_name })

-- quotes
local quotes = {
  "Change is neither good nor bad. It simply is.",
  "You're good. Get better. Stop asking for things.",
  "Why does everybody need to talk about everything?",
  "Today's a good day for Armageddon.",
  "In the highest level a man has the look of knowing nothing.",
  "Even if it seems certain that you will lose, retaliate.",
  "The end is important in all things.",
  "Having only wisdom and talent is the lowest tier of usefulness.",
  "Fear stimulates my imagination.",
  "I'm living like there's no tomorrow, cause there isn't one."
}
local quote_title = wibox.widget {
  ufont.h5(icons.misc.quote),
  widget = mat_text({ lv = "disabled" })
}
local quote = wibox.widget {
  ufont.body_2(quotes[math.random(#quotes)]),
  widget = mat_text({})
}
local quote_widget = widget.box("vertical", { quote_title, quote }, dpi(8))

-- date
local day = wibox.widget.textclock("%d")
day.font = M.f.h4
day.align = "center"

local month = wibox.widget.textclock("%B")
month.font = M.f.body_1
month.align = "left"
month.text = month.text:sub(1,3)
month:connect_signal("widget::redraw_needed", function()
  month.text = month.text:sub(1,3)
end)

local date_widget = wibox.widget {
  {
    day,
    fg = M.x.primary,
    widget = wibox.container.background
  },
  {
    month,
    fg = M.x.secondary,
    widget = wibox.container.background
  },
  layout = wibox.layout.fixed.vertical
}

-- function for buttons
local launch_term = function(cmd)
  app.start(cmd, true, nil, start_screen_hide)
end

-- buttons apps
local gimp = button({
  fg_icon = M.x.primary,
  icon = ufont.h1(""),
  height = dpi(120),
  command = function() exec_prog("gimp") end
})

local game = button({
  fg_icon = M.x.secondary,
  icon = ufont.h1(""),
  height = dpi(120),
  command = function() exec_prog("lutris") end
})

local pentest = button({
  fg_icon = M.x.error,
  icon = ufont.h1("ﮊ"),
  height = dpi(120),
  command = function() launch_term("msfconsole") end
})

local buttons_widget = widget.box('vertical', { gimp, game, pentest })

-- buttons path
local image = button({
  fg_icon = M.x.primary,
  text = ufont.button("IMAGES"),
  command = function() launch_term(file_browser .. " ~/images") end
})

local torrent = button({
  fg_icon = M.x.secondary,
  text = ufont.button("TORRENTS"),
  command = function() launch_term(file_browser .. " ~/torrents") end
})

local movie = button({
  fg_icon = M.x.error,
  text = ufont.button("MOVIES"),
  command = function() launch_term(file_browser .. " ~/videos") end
})

local buttons_path_1_widget = widget.box('horizontal', { image,torrent }, 10)
local buttons_path_2_widget = widget.box('horizontal', { movie })

-- buttons url
local github = button({
  fg_icon = M.x.primary,
  icon = ufont.h1(""),
  height = dpi(120),
  command = function() open_link("https://github.com/szorfein") end
})

local twitter = button({
  fg_icon = M.x.secondary,
  icon = ufont.h1(""),
  height = dpi(120),
  command = function() open_link("https://twitter.com/szorfein") end
})

local reddit = button({
  fg_icon = M.x.error,
  icon = ufont.h1(""),
  height = dpi(120),
  command = function() open_link("https://reddit.com/user/szorfein") end
})

local buttons_url_widget = widget.box('vertical', { github, twitter, reddit })

-- Minimal TodoList
local todo_textbox = wibox.widget.textbox() -- to store the prompt
local history_file = os.getenv("HOME").."/.todoslist"
local todo_max = 4
local todo_list = wibox.layout.fixed.vertical()
local remove_todo

local function update_history()
  local lines = {}

  -- ensure the file exist
  local history = io.open(history_file, "r")
  if history == nil then return end
  history:close()

  todo_list:reset()
  for line in io.lines(history_file) do
    table.insert(lines, line)
  end

  for k,v in pairs(lines) do
    if k > todo_max or not v then return end
    local f = function() remove_todo(v) end -- serve to store the actual line
    local b = button({
      fg_icon = M.x.secondary,
      fg_text = M.x.on_surface,
      icon = ufont.button(""),
      text = ufont.body_2(v),
      margins = dpi(4),
      spacing = dpi(8),
      command = f,
      layout = "horizontal"
    })
    todo_list:add(b)
  end
end

remove_todo = function(line)
  local line = string.gsub(line, "/", "\\/") -- if contain slash
  local command = "sh -c '[ -f "..history_file.." ] && sed -i \"/"..line.."/d\" "..history_file.."'"
  awful.spawn.easy_async_with_shell(command, function()
    update_history()
  end)
end

local function exec_prompt()
  awful.prompt.run {
    prompt = " > ",
    fg = M.f.on_surface, 
    font = M.f.body_2,
    history_path = history_file,
    textbox = todo_textbox,
    exe_callback = function(input)
      if not input or #input == 0 then return end
      update_history()
    end
  }
end

local todo_new = button({
  fg_icon = M.x.on_secondary,
  icon = ufont.button(" New task"),
  bg = M.x.secondary_variant_2,
  rrect = 24,
  margins = 15,
  mode = "contained",
  command = exec_prompt,
})

local todo_widget = wibox.widget {
  {
    {
      todo_list,
      left = 20,
      right = 20,
      top = 14,
      widget = wibox.container.margin
    },
    nil,
    {
      todo_textbox,
      {
        widget.centered(todo_new),
        bottom = 12,
        widget = wibox.container.margin
      },
      layout = wibox.layout.fixed.vertical
    },
    spacing = dpi(10),
    expand = "none",
    layout = wibox.layout.align.vertical
  },
  bg = M.x.surface,
  forced_height = todo_height - 20,
  forced_width = todo_width - 20,
  widget = wibox.container.background
}

update_history() -- init once the todo

local function boxes(w, width, height)
  local width, height = width, height or 1, 1
  local margin = 3
  local boxed_widget = wibox.widget {
    {
      widget.centered(
      {
        widget.centered(w, "vertical"),
        margins = dpi(10),
        widget = wibox.container.margin,
      }),
      bg = M.x.surface,
      forced_height = dpi(height),
      forced_width = dpi(width),
      shape = helper.rrect(20),
      widget = wibox.container.background
    },
    margins = dpi(margin),
    color = "#00000000",
    widget = wibox.container.margin
  }
  return boxed_widget
end

-- Calendar

local styles = {}
styles.focus   = {
  padding  = 2,
  fg_color = M.x.primary,
  markup   = function(t) return '<b>' .. t .. '</b>' end,
}

local function decorate_cell(widget, flag, date)
  local props = styles[flag] or {}
  if props.markup and widget.get_text and widget.set_markup then
    widget:set_markup(props.markup(widget:get_text()))
  end
  local ret = wibox.widget {
    {
      widget,
      margins = (props.padding or 0) + (props.border_width or 0),
      widget  = wibox.container.margin
    },
    shape              = props.shape,
    shape_border_color = M.x.primary_variant_1,
    shape_border_width = props.border_width or 0,
    fg                 = props.fg_color or M.x.on_surface .. "B3", -- 70%
    bg                 = props.bg_color or M.x.surface .. M.e.dp01,
    widget             = wibox.container.background
  }
  return ret
end

local calendar = wibox.widget {
  date         = os.date('*t'),
  font         = M.f.caption,
  fn_embed = decorate_cell,

  spacing      = 8,
  week_numbers = false,
  start_sunday = false,
  widget       = wibox.widget.calendar.month
}

local startscreen = class()

function startscreen:init(s)

  s.start_screen = modal:init(s)

  s.start_screen:buttons(gtable.join(
    awful.button({}, 3, function() start_screen_hide() end)
  ))

  local w = wibox.widget {
    {
      boxes(date_widget, 100, 120),
      boxes(buttons_widget, 100, 376),
      layout = wibox.layout.fixed.vertical
    },
    widget.centered(
    {
      boxes(picture_widget, 210, 210),
      boxes(quote_widget, 210, 210),
      layout = wibox.layout.fixed.vertical
    }, "vertical"),
    {
      boxes(rss_widgets, feed_width, feed_height),
      boxes(todo_widget, todo_width, todo_height),
      layout = wibox.layout.fixed.vertical
    },
    widget.centered(
    {
      boxes(calendar, 210, 260),
      boxes(buttons_path_1_widget, 210, 80),
      boxes(buttons_path_2_widget, 210, 80),
      layout = wibox.layout.fixed.vertical
    }, "vertical"),
    {
      boxes(buttons_url_widget, 100, 376),
      boxes(wibox.widget { layout = wibox.layout.fixed.vertical }, 100, 120),
      layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.fixed.horizontal
  }

  modal:run_center(w)
end

return startscreen
