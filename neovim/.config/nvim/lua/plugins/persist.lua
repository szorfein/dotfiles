return {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    --opts = {},
    config = function()
        require('persistence').setup()
    end,
    keys = {
        {
            '<leader>ss',
            function()
                require('persistence').select()
            end,
            desc = 'Session, Select one.',
        },
        {
            '<leader>sl',
            function()
                require('persistence').load()
            end,
            desc = 'Session, load the last in this directory.',
        },
    },
}
