return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
            ensure_installed = { "bash", "lua", "markdown", "markdown_inline", "query", "org", "scss", "graphql", "sql", "vim", "vimdoc", "javascript", "html", "yaml", "ruby", "rust", "vue", "yuck" },
            sync_install = false,
            highlight = { enable = true },
            incremental_selection = { enable = true },
            indent = { enable = true },  
        })
    end
}
