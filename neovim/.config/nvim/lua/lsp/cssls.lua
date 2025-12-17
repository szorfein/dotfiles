return function(on_attach)
    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end,
        settings = {
            css = {
                validate = true,
                lint = {
                    unknownAtRules = 'ignore',
                },
            },
            scss = {
                validate = true,
                lint = {
                    unknownAtRules = 'ignore',
                },
            },
            less = {
                validate = true,
                lint = {
                    unknownAtRules = 'ignore',
                },
            },
        },
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss' },
        init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
        root_markers = { 'package.json', '.git' },
    }
end
