return {
    'rebelot/heirline.nvim',
    event = 'BufEnter',
    opts = function()
        local conditions = require('heirline.conditions')
        local utils = require('heirline.utils')

        -- :highlight based on catppuccin.nvim
        local colors = {
            fg = utils.get_highlight('Folded').fg,
            bg = utils.get_highlight('EndOfBuffer').fg,
            black = utils.get_highlight('TabLineFill').bg,
            --black =  utils.get_highlight("ColorColumn").bg,
            red = utils.get_highlight('DiagnosticError').fg,
            green = utils.get_highlight('String').fg,
            orange = utils.get_highlight('Boolean').fg,
            blue = utils.get_highlight('Directory').fg,
            magenta = utils.get_highlight('Special').fg,
            cyan = utils.get_highlight('Character').fg,
        }

        local leftSeparator = {
            provider = '',
            hl = { fg = 'black' },
        }

        local rightSeparator = {
            provider = '',
            hl = { fg = 'black' },
        }

        --  components
        local viMode = {
            init = function(self)
                self.mode = vim.fn.mode(1) -- :h mode()
            end,
            static = {
                mode_names = { -- :h mode()
                    n = 'N', -- normal
                    niI = 'Ni',
                    niR = 'Nr',
                    niV = 'Nv',
                    i = 'I', -- insert
                    ic = 'Ic',
                    ix = 'Ix',
                    R = 'R', -- replace
                    Rc = 'Rc',
                    Rx = 'Rx',
                    Rv = 'Rv',
                    Rvc = 'Rv',
                    Rvx = 'Rv',
                    v = 'V', -- visual
                    vs = 'V',
                    V = 'V_',
                    Vs = 'Vs',
                    ['\22'] = '^V',
                    ['\22s'] = '^V',
                    c = 'C', -- command :
                    cv = 'Ex',
                    ce = 'Ce',
                    no = 'O', -- op
                    nov = 'Ov',
                    noV = 'oV',
                    ['no\22'] = 'O?',
                    r = '...', -- app?
                    rm = 'M',
                    ['r?'] = '?',
                    ['!'] = '!',
                    t = 'T',
                },
                mode_colors = {
                    n = 'red',
                    i = 'green',
                    R = 'orange',
                    v = 'magenta',
                    V = 'magenta',
                    c = 'cyan',
                    R = 'orange', -- app?
                    r = 'orange',
                    ['!'] = 'red',
                    t = 'red',
                },
            },
            provider = function(self)
                if self.mode_names[self.mode] then
                    return ' %2(' .. self.mode_names[self.mode] .. '%)'
                end
            end,
            hl = function(self)
                local mode = self.mode:sub(1, 1) -- get only the first mode character
                return { fg = self.mode_colors[mode], bg = 'black', bold = true }
            end,
            update = {
                'ModeChanged',
                pattern = '*:*',
                callback = vim.schedule_wrap(function()
                    vim.cmd('redrawstatus')
                end),
            },
        }

        local FileType = {
            provider = function()
                return string.lower(vim.bo.filetype)
            end,
            hl = { fg = utils.get_highlight('Type').fg, bg = 'black', bold = true },
        }

        local Git = {
            condition = conditions.is_git_repo,
            init = function(self)
                self.status_dict = vim.b.gitsigns_status_dict
                self.has_changes = self.status_dict.added ~= 0
                    or self.status_dict.removed ~= 0
                    or self.status_dict.changed ~= 0
            end,
            hl = { fg = 'orange' },
            { -- git branch name
                provider = function(self)
                    return ' ' .. self.status_dict.head
                end,
                hl = { bg = 'black', bold = true },
            },
        }

        local Ruler_1 = {
            -- %l = current line number
            -- %L = number of lines in the buffer
            -- %c = column number
            -- %P = percentage through file of displayed window
            {
                provider = '%l',
                hl = { fg = 'red', bg = 'black' },
            },
            { provider = '  ', hl = { fg = 'cyan', bg = 'black' } },
            {
                provider = '%2c',
                hl = { fg = 'blue', bg = 'black' },
            },
        }

        local Ruler_2 = {
            -- %l = current line number
            -- %L = number of lines in the buffer
            -- %c = column number
            -- %P = percentage through file of displayed window
            {
                provider = '%P',
                hl = { fg = 'magenta', bg = 'black' },
            },
            { provider = '  ', hl = { fg = 'cyan', bg = 'black' } },
            {
                provider = '%2L',
                hl = { fg = 'blue', bg = 'black' },
            },
        }

        -- ret widget
        return {
            opts = {
                colors = colors,
            },
            statusline = {
                hl = { fg = 'fg', bg = 'bg' },
            },
            winbar = { -- topbar
                leftSeparator,
                viMode,
                rightSeparator,
                {
                    provider = '%=', -- align right
                },
                leftSeparator,
                FileType,
                rightSeparator,
                {
                    provider = '  ',
                },
                leftSeparator,
                Git,
                rightSeparator,
                {
                    provider = '  ',
                },
                leftSeparator,
                Ruler_1,
                rightSeparator,
                {
                    provider = '  ',
                },
                leftSeparator,
                Ruler_2,
                rightSeparator,
            },
        }
    end,
}
