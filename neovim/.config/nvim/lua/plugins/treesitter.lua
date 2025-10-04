return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    --event = { 'LazyFile', 'VeryLazy' },
    cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    opts_extend = { 'ensure_installed' },
    opts = {
        indent = { enable = true },
        highlight = { enable = true },
        folds = { enable = true },
        ensure_installed = {
            'astro',
            'bash',
            'c',
            'diff',
            'html',
            'javascript',
            'jsdoc',
            'json',
            'jsonc',
            'lua',
            'luadoc',
            'luap',
            'markdown',
            'markdown_inline',
            'printf',
            'python',
            'query',
            'regex',
            'ruby',
            'rust',
            'scss',
            'toml',
            'tmux',
            'typescript',
            'vim',
            'vimdoc',
            'vue',
            'yaml',
            'yuck',
        },
    },
    ---@param opts lazyvim.TSConfig
    config = function(_, opts)
        local TS = require('nvim-treesitter')

        -- setup treesitter
        TS.setup(opts)

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('lazyvim_treesitter', { clear = true }),
            callback = function()
                -- highlighting
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
