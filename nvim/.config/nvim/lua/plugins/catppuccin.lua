return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function(_, opts)
        local mycolors = require('colors')
        color_overrides = {
            all = {
                base = mycolors.base,
                text = mycolors.text
            }
        }
        integrations = {
            gitsigns = true,
            treesitter = true,
            indent_blankline = {
                enabled = true,
                scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                colored_indent_levels = false,
            }
        }
    end
}
