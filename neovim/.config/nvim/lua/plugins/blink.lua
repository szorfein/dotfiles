-- https://cmp.saghen.dev/installation.html
return {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
        snippets = { preset = 'luasnip' },
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
            nerd_font_variant = 'normal',
        },
        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            --list = { selection = { preselect = true, auto_insert = true } },
            accept = {
                auto_brackets = { enabled = true },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { border = 'single' },
            },
            menu = {
                scrollbar = false,
                border = 'single',
                draw = {
                    padding = 2,
                    columns = { { 'kind_icon' }, { 'label' }, { 'kind' } },
                },
            },
        },
        sources = {
            default = { 'lsp', 'snippets', 'buffer', 'path' },
        },
        fuzzy = { implementation = 'prefer_rust' },
    },
    opts_extend = { 'sources.default' },
}
