return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'mason-org/mason-lspconfig.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        -- 'trace', 'debug', 'info', 'warn', 'error'
        vim.lsp.set_log_level('error')

        local border = { border = 'shadow' }
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, border)
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, border)

        -- lsp config
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local default_lsp_config = {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 200,
                allow_incremental_sync = true,
            },
        }

        -- servers
        local servers = {
            bashls = require('lsp.bashls')(on_attach),
            lua_ls = require('lsp.luals')(on_attach),
        }
        local server_names = {}
        local server_configs = {}
        for server_name, server_config in pairs(servers) do
            table.insert(server_names, server_name)
            server_configs[server_name] = server_config
        end

        -- check mason
        local mason_ok, mason = pcall(require, 'mason')
        local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

        if mason_ok and mason_lspconfig_ok then
            mason.setup()
            mason_lspconfig.setup({
                ensure_installed = server_names,
                automatic_enable = false,
            })
            for s, c in pairs(server_configs) do
                vim.lsp.enable(vim.tbl_deep_extend('force', default_lsp_config, c or {}))
            end
        end
    end,
}
