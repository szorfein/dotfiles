return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function () 
        require'nvim-treesitter.configs'.setup {
            -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
            ensure_installed = { "astro", "bash", "lua", "markdown", "markdown_inline", "query", "gpg", "scss", "graphql", "sql", "vim", "vimdoc", "javascript", "html", "yaml", "ruby", "rust", "tmux", "vue", "yuck" },
            sync_install = false,
            highlight = { enable = true },
            incremental_selection = { enable = true },
            indent = { enable = true },  
        }
    end
}
