let g:lightline.colorscheme = 'morpho'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']] }

let g:lightline.separator = { 'right': '', 'left': '' }
let g:lightline.subseparator = { 'right': ' ', 'left': '' }

let g:lightline.active = {
  \   'left': [
  \   [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \   [ 'gitbranch' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileencoding', 'fileformat', 'filetype' ] ],
  \ }

" https://github.com/ryanoasis/vim-devicons/wiki/usage#lightline-setup
let g:lightline.component_function = {
  \   'gitbranch': 'gitbranch#name',
  \   'filetype': 'MyFiletype',
  \   'fileformat': 'MyFileformat',
  \ }

let g:lightline.inactive = {
  \   'left': [ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \           [ 'filename_active' ] ],
  \   'right':[['lineinfo']],
  \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
