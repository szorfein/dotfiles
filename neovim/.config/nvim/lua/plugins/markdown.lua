return {
    'brianhuster/live-preview.nvim',
    dependencies = {
        -- You can choose one of the following pickers
        'folke/snacks.nvim',
    },
    --enabled = false,
    keys = {
        { '<leader>mo', ':LivePreview start<CR>', desc = 'Open Markdown preview' },
        { '<leader>mc', ':LivePreview close<CR>', desc = 'Close Markdown preview' },
    },
}
