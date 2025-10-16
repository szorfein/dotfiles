return {
    'stevearc/conform.nvim',
    --event = { 'BufReadPre', 'BufNewFile' },
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    opts = {
        formatters_by_ft = {
            css = { 'prettier' },
            scss = { 'prettier' },
            graphql = { 'prettier' },
            html = { 'prettier' },
            javascript = { 'prettier', stop_after_first = true },
            json = { 'prettier' },
            lua = { 'stylua' },
            markdown = { 'prettier' },
            ruby = { 'rubocop' },
            sh = { 'shfmt' },
            typescript = { 'prettier' },
            yaml = { 'prettier' },
            vue = { 'prettier' },
        },
        formatters = {
            shfmt = {
                command = 'shfmt',
                prepend_args = { '-p', '-i', '0', '-sr', '-bn' },
            },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = 'fallback',
        },
        -- Set up format-on-save
        format_on_save = {
            lsp_format = 'fallback',
            async = false,
            --timeout_ms = 500,
        },
    },
}
