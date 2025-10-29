return {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    --opts = {},
    config = function()
        require('persistence').setup()
    end,
}
