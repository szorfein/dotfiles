local wibox = require('wibox')

local line = class()

function line:init()
    self.background = wibox.widget({
        widget = wibox.container.background,
    })
    self.title = wibox.widget({
        font = md.sys.typescale.body_medium.font .. ' ' .. md.sys.typescale.body_medium.size,
        widget = wibox.widget.textbox,
    })
    self.content = wibox.widget({
        font = md.sys.typescale.body_small.font .. ' ' .. md.sys.typescale.body_medium.size,
        forced_height = 24, -- one line
        widget = wibox.widget.textbox,
    })
    self.widget = wibox.widget({
        {
            self.title,
            widget = self.background,
        },
        self.content,
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal,
    })
end

function line:set(title, content, fg)
    self.title.text = title
    self.content.text = content
    self.background.fg = fg
end

local sysfetch = class()

function sysfetch:init()
    self.os = line()
    self.up = line()
    self.pk = line()
    self.rd = line()
    self:signals()
    return self:widget()
end

function sysfetch:widget()
    return wibox.widget({
        self.os.widget,
        self.up.widget,
        self.pk.widget,
        self.rd.widget,
        spacing = dpi(8),
        layout = wibox.layout.fixed.vertical,
    })
end

function sysfetch:signals()
    awesome.connect_signal('daemon::os', function(release, uptime, pkgs, entropy)
        self.os:set('OS:', release, md.sys.color.primary)
        self.up:set('UP:', uptime, md.sys.color.secondary)
        self.pk:set('PK:', pkgs, md.sys.color.tertiary)
        self.rd:set('RD:', entropy, md.sys.color.secondary)
    end)
end

return sysfetch
