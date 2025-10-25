return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        delay = 400,
        triggers = {
            { '<auto>', mode = 'nixsotc' },
            { 'a', mode = { 'n', 'v' } },
        },
    },
    keys = {
        {
            '<C-h>b',
            function()
                --require('which-key').show({ global = false })
                require('which-key').show()
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}
