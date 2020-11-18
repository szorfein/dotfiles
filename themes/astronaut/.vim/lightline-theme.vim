let g:lightline.colorscheme = "vamp"
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']] }
let g:lightline.component = { 'close':  ' X ' }
let g:lightline.separator = { 'right': '', 'left': '' }
let g:lightline.separator = { 'right': '', 'left': '' }
let g:lightline.active = {
  \   'left': [ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \             [ 'gitbranch' ] ],
  \   'right': [ [ 'percent', 'lineinfo', 'fileformat' ],
  \              [ 'filencode', 'filetype' ] ],
  \ }
let g:lightline.inactive = {
  \   'left': [ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \           [ 'filename_active' ] ],
  \   'right':[['lineinfo']],
  \ }
