-- https://cmp.saghen.dev/installation.html
return {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
        keymap = {
            ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-J>'] = { 'select_next', 'fallback' },
            ['<C-K>'] = { 'select_prev', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<Tab>'] = {
                'select_next',
                'snippet_forward',
                function(cmp)
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return cmp.show()
                    end
                end,
                'fallback',
            },
            ['<S-Tab>'] = {
                'select_prev',
                'snippet_backward',
                function(cmp)
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return cmp.show()
                    end
                end,
                'fallback',
            },
        },
        appearance = {
            nerd_font_variant = 'iosevka',
        },
        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            list = { selection = { preselect = true, auto_insert = true } },
            accept = {
                auto_brackets = { enabled = true },
            },
            documentation = { auto_show = false },
        },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            --default = { 'lsp', 'path', 'snippets', 'buffer' },
            default = { 'path', 'snippets', 'buffer' },
        },
        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
}
