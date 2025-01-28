local mycolors = require('colors')

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        color_overrides = {
            all = {
                maroon = mycolors.maroon,
                lavender = mycolors.lavender,
                blue = mycolors.blue,
                pink = mycolors.pink,
                mauve = mycolors.mauve,
                text = mycolors.text,
                --crust = mycolors.crust,
                mantle = mycolors.mantle,
                base = mycolors.base,
                surface0 = mycolors.surface0, --comment
                --surface1 = mycolors.surface1,
                --surface2 = mycolors.surface2,
            }
        },
        integrations = {
            gitsigns = true,
            treesitter = true,
            indent_blankline = {
                enabled = true,
                scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                colored_indent_levels = false,
            }
        }
    }
}
