return function(on_attach)
    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end,
        cmd = { 'harper-ls', '--stdio' },
        filetypes = {
            'c',
            'cpp',
            'cs',
            'gitcommit',
            'go',
            'html',
            'java',
            'javascript',
            'lua',
            'markdown',
            'nix',
            'python',
            'ruby',
            'rust',
            'swift',
            'toml',
            'typescript',
            'typescriptreact',
            'haskell',
            'cmake',
            'typst',
            'php',
            'dart',
            'clojure',
            'sh',
        },
        root_markers = { '.git' },
    }
end
