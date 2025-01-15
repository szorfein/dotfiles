return {
    "rebelot/heirline.nvim",
    event = "BufEnter",
    opts = function()
        local conditions = require("heirline.conditions")
        local utils = require("heirline.utils")

        -- :highlight based on catppuccin.nvim
        local colors = {
            fg = utils.get_highlight("Folded").fg,
            bg = utils.get_highlight("EndOfBuffer").fg,
            --black =  utils.get_highlight("TabLineFill").bg,
            black =  utils.get_highlight("ColorColumn").bg,
            red = utils.get_highlight("DiagnosticError").fg,
            green = utils.get_highlight("String").fg,
            orange = utils.get_highlight("Boolean").fg, 
            magenta = utils.get_highlight("Special").fg,
            cyan = utils.get_highlight("Character").fg,
        }

        local leftSeparator = {
            provider = '',
            hl = { fg = 'black' }
        }

        local rightSeparator = {
            provider = '',
            hl = { fg = 'black' }
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
                    c = 'C', -- command :
                    cv = 'Ex',
                    ce = 'Ce',
                    no = 'O', -- op
                    nov = 'Ov',
                    noV = 'oV',
                    ["no\22"] = "O?",
                },
                mode_colors = {
                    n = 'red',
                    i = 'green',
                    R = 'orange',
                    v = 'magenta',
                    V = 'magenta',
                    c = 'cyan',
                }
            },
            provider = function(self)
                return " %2("..self.mode_names[self.mode].."%)"
            end,
            hl = function(self)
                local mode = self.mode:sub(1, 1) -- get only the first mode character
                return { fg = self.mode_colors[mode], bg = 'black', bold = true, }
            end,
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            }
        }

        -- ret widget
        return {
            opts = {
                colors = colors
            },
            statusline = {
                hl = { fg = 'fg', bg = 'bg' }
            },
            winbar = { -- topbar
                leftSeparator,
                viMode,
                rightSeparator
            }
        }
    end
}
