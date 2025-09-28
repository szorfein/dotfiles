-- https://github.com/folke/snacks.nvim/blob/main/docs
return {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    opts = {
        -- configure indent
        indent = {
            enabled = true,
            char = '▏',
            animate = { enabled = false },
            scope = {
                enabled = true,
                char = '▏',
            },
            -- filter for buffers to enable indent guides
            filter = function(buf)
                return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
            end,
        },

        -- configure notifier
        notifier = {
            icons = {
                error = ' ',
                warn = ' ',
                info = ' ',
                debug = ' ',
                trace = ' ',
            },
        },

        -- configure picker
        picker = {
            ui_select = true,
        },

        -- configure scope
        scope = {
            filter = function(buf)
                return vim.bo[buf].buftype == '' and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false
            end,
        },
    },
}
