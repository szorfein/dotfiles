local vim = vim
local map = vim.keymap.set

return {
    'stevearc/resession.nvim',
    enabled = false,
    config = function()
        local resession = require('resession')
        resession.setup({
            extensions = {},
            autosave = {
                enabled = true,
                interval = 60,
                notify = true,
            },
        })

        local function create_name()
            local last_dir = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h:t')
            return last_dir .. '/' .. vim.fn.expand('%:t')
        end

        -- one session per dir
        vim.api.nvim_create_autocmd('VimEnter', {
            callback = function()
                -- Only load the session if nvim was started with no args and without reading from stdin
                if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
                    -- Save these to a different directory, so our manual sessions don't get polluted
                    resession.load(vim.fn.getcwd(), { dir = 'dirsession', silence_errors = true })
                end
            end,
            nested = true,
        })

        vim.api.nvim_create_autocmd('VimLeavePre', {
            callback = function()
                resession.save(vim.fn.getcwd(), { dir = 'dirsession', notify = false })
            end,
        })

        vim.api.nvim_create_autocmd('StdinReadPre', {
            callback = function()
                -- Store this for later
                vim.g.using_stdin = true
            end,
        })

        -- shortcut
        map('n', '<c-x>s', function()
            resession.save(create_name())
        end, { desc = 'Save current session' })
        map('n', '<c-x>b', function()
            resession.load(nil) -- { attach = false })
        end, { desc = 'Load a session' })
        map('n', '<c-x>k', resession.delete, { desc = 'Delete a session' })
    end,
}
