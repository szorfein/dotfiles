local vim = vim
local map = vim.keymap.set
local icon = require('utils.icon')

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'mason-org/mason-lspconfig.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        -- 'trace', 'debug', 'info', 'warn', 'error'
        vim.lsp.set_log_level('error')

        -- keybind shortcuts
        local function on_attach(client, bufnr)
            local function buf_set_option(o, v)
                vim.api.nvim_set_option_value(o, v, { buf = bufnr })
            end
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            local opts = { buffer = bufnr }

            local cap = client.server_capabilities
            if cap.definitionProvider then
                map('n', 'gD', vim.lsp.buf.definition, opts)
            end
        end

        -- config diagnostic
        -- https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts
        vim.diagnostic.config({
            virtual_text = {
                -- source = "always",  -- Or "if_many"
                prefix = '●', -- Could be '■', '▎', 'x'
            },
            severity_sort = true,
            float = {
                source = 'always', -- Or "if_many"
                border = 'rounded',
                --border = 'shadow',
                focused = false,
                focus = false,
                style = 'minimal',
                header = '',
                prefix = '',
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icon.get('DiagnosticError'),
                    [vim.diagnostic.severity.HINT] = icon.get('DiagnosticHint'),
                    [vim.diagnostic.severity.WARN] = icon.get('DiagnosticWarn'),
                    [vim.diagnostic.severity.INFO] = icon.get('DiagnosticInfo'),
                },
            },
        })

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
            codebook = require('lsp.codebook')(on_attach),
            lua_ls = require('lsp.luals')(on_attach),
            --harper_ls = require('lsp.harper_ls')(on_attach),
            rubocop = require('lsp.rubocop')(on_attach),
            --standardrb = require('lsp.standardrb')(on_attach),
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
                vim.lsp.enable(s, vim.tbl_deep_extend('force', default_lsp_config, c or {}))
            end
        end
    end,
}
