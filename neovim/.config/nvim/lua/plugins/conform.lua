local prettier = { 'prettier', stop_after_first = true }

return {
    -- ansible files are not properly detected without this
    { 'mfussenegger/nvim-ansible' },
    {
        'stevearc/conform.nvim',
        --event = { 'BufReadPre', 'BufNewFile' },
        event = 'BufWritePre',
        cmd = { 'ConformInfo' },
        opts = {
            formatters_by_ft = {
                css = prettier,
                scss = { 'prettier' },
                graphql = { 'prettier' },
                html = prettier,
                --javascript = { 'standardjs' },
                javascript = prettier,
                json = prettier,
                lua = { 'stylua' },
                markdown = { 'prettier' },
                --ruby = { 'rubocop' },
                ruby = { 'rufo' },
                sh = { 'shfmt' },
                typescript = prettier,
                vue = { 'prettier' },
                yaml = prettier,
                ['yaml.ansible'] = { 'ansible-lint' },
            },
            formatters = {
                prettier = {
                    command = 'prettier',
                    prepend_args = { '-w' },
                },
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
                --async = false,
                timeout_ms = 2900,
            },
        },
        keys = {
            {
                '<leader>rf',
                function()
                    require('conform').format({ async = true })
                end,
                desc = 'format buffer',
            },
        },
    },
}
