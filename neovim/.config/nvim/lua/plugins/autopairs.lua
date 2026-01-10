return {
    'windwp/nvim-autopairs',
    enabled = false,
    event = 'InsertEnter',
    opts_extend = { 'disable_filetype' },
    opts = {
        check_ts = true,
        ts_config = { java = false },
        disable_filetype = { 'TelescopePrompt', 'vim' },
        fast_wrap = {
            map = '<M-e>',
            chars = { '{', '[', '(', '"', "'" },
            pattern = ([[ [%'%"%)%>%]%)%}%,] ]]):gsub('%s+', ''),
            offset = 0,
            end_key = '$',
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            check_comma = true,
            highlight = 'PmenuSel',
            highlight_grey = 'LineNr',
        },
    },
    config = function(...)
        require('configs.nvim-autopairs')(...)
    end,
}
