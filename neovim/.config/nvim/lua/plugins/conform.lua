return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    opts = {
        formatters_by_ft = {
            css = { 'prettier' },
            lua = { 'stylua' },
            html = { 'prettier' },
            javascript = { 'prettier', stop_after_first = true },
            markdown = { 'prettier' },
            ruby = { 'rubocop' },
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
