let g:lightline.colorscheme = 'ombre'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']] }

let g:lightline.separator = { 'right': '', 'left': '' }
let g:lightline.subseparator = { 'right': '', 'left': '' }

let g:lightline.active = {
  \   'left': [
  \   [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \   [ 'gitbranch' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
  \ }

let g:lightline.component_function = {
  \   'gitbranch': 'gitbranch#name'
  \ }

let g:lightline.inactive = {
  \   'left': [ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \           [ 'filename_active' ] ],
  \   'right':[['lineinfo']],
  \ }
