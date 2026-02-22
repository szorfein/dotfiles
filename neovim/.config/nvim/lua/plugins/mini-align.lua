return {
    'nvim-mini/mini.align',
    version = false,
    event = 'VeryLazy',
    config = function()
        require('mini.align').setup({ silent = true })
    end,
}
