local vim = vim

return {
    'mason-org/mason.nvim',
    build = ':MasonInstallAll',
    config = function()
        require('mason').setup({
            ui = {
                border = 'shadow',
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        })
        local cmd = function(name, cmd, desc)
            vim.api.nvim_create_user_command(name, cmd, desc)
        end

        cmd('MasonInstallAll', function()
            local function filter_missing_tools(tools)
                local missing = {}
                for _, tool in ipairs(tools) do
                    if vim.fn.executable(tool) ~= 1 then
                        table.insert(missing, tool)
                    end
                end
                return missing
            end

            vim.cmd('MasonUpdate')

            local ensure_installed = {
                'stylua',
                'prettier',
                'shfmt',
                'lua-language-server',
            }
            local missing_tools = filter_missing_tools(ensure_installed)
            if #missing_tools > 0 then
                vim.cmd('MasonInstall ' .. table.concat(missing_tools, ' '))
            end
        end, { desc = 'install lsp tools' })
    end,
}
