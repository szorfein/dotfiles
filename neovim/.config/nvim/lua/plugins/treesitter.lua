return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    --event = { 'LazyFile', 'VeryLazy' },
    cmd = { 'TSUpdate', 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSLog', 'TSUninstall' },
    opts_extend = { 'ensure_installed' },
    opts = {
        indent = { enable = true },
        highlight = { enable = true, use_languagetree = true },
        folds = { enable = true },
        ensure_installed = { 'lua', 'luadoc', 'printf', 'vim', 'vimdoc' },
    },
    ---@param opts lazyvim.TSConfig
    config = function(_, opts)
        local TS = require('nvim-treesitter')

        -- setup treesitter
        TS.setup(opts)

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter', { clear = true }),
            callback = function()
                -- highlighting
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
