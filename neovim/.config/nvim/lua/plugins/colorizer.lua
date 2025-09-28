return {
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPost' },
    cmd = 'HighlightColors',
    opts = {
        render = 'background',
        enable_tailwind = true,
        enable_hex = true,
        virtual_symbol = '󱓻',
    },
}
