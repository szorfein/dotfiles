return function(on_attach)
    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end,
        cmd = { 'codebook-lsp', 'serve' },
        filetypes = {
            'c',
            'css',
            'gitcommit',
            'go',
            'haskell',
            'html',
            'java',
            'javascript',
            'javascriptreact',
            'lua',
            'markdown',
            'php',
            'python',
            'ruby',
            'rust',
            'toml',
            'text',
            'typescript',
            'typescriptreact',
        },
        root_markers = { '.git', 'codebook.toml', '.codebook.toml' },
    }
end
