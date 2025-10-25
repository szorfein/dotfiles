-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
-- :lua vim.lsp.enable('lua_ls')
return function(on_attach)
    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false
        end,
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        settings = {
            Lua = {
                hint = {
                    enable = true,
                },
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- this don't works
                    -- [#1788](https://github.com/LuaLS/lua-language-server/issues/1788)
                    globals = { 'vim', 'awesome' },
                },
                workspace = {
                    checkThirdParty = false,
                    -- make the server aware of Neovim runtime files
                    -- library = {
                    -- 	[vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    -- 	[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                    -- },
                },
                -- do not send telemetry data containing a randomized but unique identifier
                telemetry = { enable = false },
            },
        },
    }
end
