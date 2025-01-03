-- example: https://github.com/itchyny/lightline.vim/issues/657
-- doc: https://github.com/itchyny/lightline.vim/blob/master/doc/lightline.txt
return {
    "itchyny/lightline.vim",
    config = function()
        vim.g.lightline = {
            active = {
            left = {
                    { 'mode', 'paste', 'sep1' },
                    { 'readonly', 'filename', 'modified' },
                    { },
                },
                right = {
                    { 'lineinfo' },
                    { 'percent' },
                    { 'filetype' } 
                }
            },
            inactive = {
                left = {
                    { 'mode', 'paste', 'sep1' },
                    { 'readonly', 'filename', 'modified' },
                    { 'percent' },
                    { 'filetype' }
                }
            },
            tabline = {
                left = {
                    { 'tabs' }
                },
                right = {
                    { }
                }
            },
            tab = {
                active = {
                    { 'tabnum', 'filename', 'modified' }
                },
                inactive = {
                    { 'tabnum', 'filename', 'modified' }
                }
            },
            component = {
                mode = "%{lightline#mode()}",
                absolutepath = "%F",
                relativepath = "%f",
                filename = "%t",
                modified = "%M",
                bufnum = "%n",
                paste = '%{&paste?"PASTE":""}',
                readonly = "%R",
                charvalue = "%b",
                charvaluehex = "%B",
                fileencoding = '%{&fenc!=#""?&fenc:&enc}',
                fileformat = '%{&ff}',
                filetype = '%{&ft!=#""?&ft:"no ft"}',
                percent = '%3p%%',
                percentwin = '%P',
                spell = '%{&spell?&spelllang:""}',
                lineinfo = '%3l:%-2v',
                line = '%l',
                column = '%c',
                close = '%999X X ',
                winnr = '%{winnr()}',
                sep1 = ''
            },
            separator = {
                left = '',
                right = ''
            },
            subseparator = {
                left = '',
                right = ''
            },
            enable = {
                statusline = 1,
                tabline = 1
            }
        }
        vim.g.lightline.tabline_separator = vim.g.lightline.separator
        vim.g.lightline.tabline_subseparator = vim.g.lightline.subseparator
    end
}
