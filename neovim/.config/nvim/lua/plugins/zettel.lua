return {
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },
    {
        'vimwiki/vimwiki',
        init = function()
            -- for all options > :help vim-zettel
            vim.g.vimwiki_list = { { path = '~/documents/notes/', ext = '.md', syntax = 'markdown' } }
            -- [#1304](https://github.com/vimwiki/vimwiki/issues/1304)
            vim.g.vimwiki_global_ext = 0 -- don't treat all md files as vimwiki (0)
            vim.g.vimwiki_hl_headers = 1 -- use alternating colors for different heading levels
            vim.g.vimwiki_markdown_link_ext = 1 -- add markdown file extension when generating links
            vim.g.taskwiki_markdown_syntax = 'markdown'
        end,
    },
    {
        'michal-h21/vim-zettel',
        init = function()
            -- for all options > :help vim-zettel
            vim.g.nv_search_paths = { '~/documents/notes' }
        end,
        -- more shortcuts on note: https://github.com/chipsenkbeil/org-roam.nvim/blob/main/DOCS.org#coming-from-emacs
        keys = {
            { '<C-c>nn', ':ZettelNew<space>', desc = 'New note' },
            { '<C-c>nf', ':ZettelOpen<CR>', desc = 'Find notes' },
        },
    },
}
