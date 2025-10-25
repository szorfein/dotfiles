return {
    'folke/trouble.nvim',
    --optional = true,
    event = 'VeryLazy',
    specs = {
        'folke/snacks.nvim',
        opts = function(_, opts)
            return vim.tbl_deep_extend('force', opts or {}, {
                picker = {
                    actions = require('trouble.sources.snacks').actions,
                    win = {
                        input = {
                            keys = {
                                ['<c-t>'] = {
                                    'trouble_open',
                                    mode = { 'n', 'i' },
                                },
                            },
                        },
                    },
                },
            })
        end,
    },
    opts = {
        modes = {
            diagnostics = {
                auto_open = false,
                auto_close = true,
            },
        },
        warn_no_results = false,
    },
    keys = {
        {
            '<leader>tt',
            '<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>',
            desc = 'trouble diagnostics',
        },
        {
            '<leader>tT',
            '<cmd>Trouble diagnostics toggle focus=true<cr>',
            desc = 'project diagnostics',
        },
    },
}
