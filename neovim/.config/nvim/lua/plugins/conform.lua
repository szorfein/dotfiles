return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    opts = {
        formatters_by_ft = {
            css = { 'prettier' },
            graphql = { 'prettier' },
            html = { 'prettier' },
            javascript = { 'prettier', stop_after_first = true },
            json = { 'prettier' },
            lua = { 'stylua' },
            markdown = { 'prettier' },
            ruby = { 'rubocop' },
            typescript = { 'prettier' },
            yaml = { 'prettier' },
            vue = { 'prettier' },
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
