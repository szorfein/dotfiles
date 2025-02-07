return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        --indent = { char = "▏" },
        indent = { char = '╎' },
        scope = { show_start = false, show_end = false },
        exclude = {
            buftypes = {
                "nofile",
                "prompt",
                "quickfix",
                "terminal",
            },
            filetypes = {
                "aerial",
                "alpha",
                "dashboard",
                "help",
                "lazy",
                "mason",
                "neo-tree",
                "NvimTree",
                "neogitstatus",
                "notify",
                "startify",
                "toggleterm",
                "Trouble",
            },
        }
    }
}
