return function(on_attach)
    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end,
        cmd = { 'rubocop', '--lsp' },
        filetypes = { 'ruby' },
        root_markers = { 'Gemfile', '.git' },
    }
end
