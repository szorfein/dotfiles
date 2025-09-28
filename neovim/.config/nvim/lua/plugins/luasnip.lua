-- docs
-- https://docs.astronvim.com/recipes/snippets/
return {
    'L3MON4D3/LuaSnip',
    lazy = true,
    dependencies = { { 'rafamadriz/friendly-snippets', lazy = true } },
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    opts = {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
    },
    specs = {
        { 'saghen/blink.cmp', optional = true, opts = { snippets = { preset = 'luasnip' } } },
    },
    config = function(_, opts)
        require('luasnip').config.set_config(opts)
        -- vscode format
        require('luasnip.loaders.from_vscode').lazy_load({ exclude = vim.g.vscode_snippets_exclude or {} })
        require('luasnip.loaders.from_vscode').lazy_load({
            --paths = vim.g.vscode_snippets_path or ''
            paths = { vim.fn.stdpath('config') .. '/snippets' },
        })

        -- snipmate format
        require('luasnip.loaders.from_snipmate').load()
        require('luasnip.loaders.from_snipmate').lazy_load({ paths = vim.g.snipmate_snippets_path or '' })

        -- lua format
        require('luasnip.loaders.from_lua').load()
        require('luasnip.loaders.from_lua').lazy_load({ paths = vim.g.lua_snippets_path or '' })
    end,
}
