"" Gruvbox colorscheme
let g:gruvbox_contrast_dark = 'soft'
set background=dark

"" NERDTree Configuration, https://github.com/scrooloose/nerdtree
let NERDTreeChDirMode = 2
let NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.sqlite$', '__pycache__']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$','\.bak$', '\~$']
let NERDTreeShowBookmarks = 1
let NERDTree_tabs_focus_on_files=1
let NERDTreeMapOpenInTabSilent = '<RightMouse>'
let NERDTreeWinSize = 25
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <F3> :NERDTreeToggle<CR>

" vim-tmux-navigator, https://github.com/christoomey/vim-tmux-navigator#vim-1
let g:tmux_navigator_no_mappings=1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
nnoremap <silent> <C-BS> :TmuxNavigatePrevious<CR>

" gitbutter
let g:gitgutter_realtime = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'

" linting
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = ' '
let g:ale_sign_warning = ' '
"let g:ale_open_list = 1
let g:ale_list_window_size = 3
"let g:ale_lint_on_text_changed = 'never'
highlight ALEErrorSign ctermbg=0 ctermfg=magenta

"" Lightline.vim, http://git.io/lightline
set laststatus=2

" show lightline-bufferline
set showtabline=2

" default lightline configuration
let g:lightline = {
  \ 'component_function': {
  \   'filename': 'FileName',
  \   'gitbranch': 'GitBranch',
  \   'filencode': 'FileEncoding',
  \   'readonly': 'LightLineReadonly',
  \   'filename_active': 'LightlineFilenameActive',
  \   'filetype': 'LightLineFiletype',
  \   'fileformat': 'LightLineFileformat',
  \   'lineinfo': 'LightlineLineinfo',
  \ },
  \ 'component_expand': {
  \   'linter_checking': 'WizChecking',
  \   'linter_warnings': 'WizWarnings',
  \   'linter_errors': 'WizErrors',
  \   'linter_ok': 'WizOk',
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \   'buffers': 'tabsel',
  \ }
  \}

" lighline functions
function! FileName()
  let l:fn = expand("%:t")
  let l:ro = &ft !~? 'help' && &readonly ? " RO" : ""
  let l:mo = &modifiable && &modified ? " +" : ""
  return l:fn . l:ro . l:mo
endfunction

function! GitBranch()abort
  return !IsTree() ? exists('*fugitive#head') ? fugitive#head() : '' : ''
endfunction

function FileEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

function LightLineFiletype()
  "return winwidth(0) > 70 ? (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : '') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! IsTree()
  let l:name = expand('%:t')
  return l:name =~ 'NetrwTreeListing\|undotree\|NERD' ? 1 : 0
endfunction

function! LightlineLineinfo() abort
  if winwidth(0) < 86
    return ''
  endif

  let l:current_line = printf('%-3s', line('.'))
  let l:max_line = printf('%-3s', line('$'))
  let l:lineinfo = ' ' . l:current_line . '/' . l:max_line
  return l:lineinfo
endfunction

""""""""""""""""
let s:indicator_checking = get(g:, 'lightline#ale#indicator_checking', ' ')
let s:indicator_ok = get(g:, 'lightline#ale#indicator_ok', ' ')

function! WizWarnings() abort
  if !WizLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors == 0 ? '' : printf(' %d', all_non_errors)
endfunction

function! WizErrors() abort
  if !WizLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  " ×   
  return l:all_errors == 0 ? '' : printf(' %d', all_errors)
endfunction

function! WizOk() abort
  if !WizLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? s:indicator_ok : ''
endfunction

function! WizChecking() abort
  return ale#engine#IsCheckingBuffer(bufnr('')) ? s:indicator_checking : ''
endfunction

function! WizLinted() abort
  return get(g:, 'ale_enabled', 0) == 1
        \ && getbufvar(bufnr(''), 'ale_linted', 0) > 0
        \ && ale#engine#IsCheckingBuffer(bufnr('')) == 0
endfunction

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#number_map = {
  \ 0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
  \ 5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '}

" Leader is , 
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

augroup alestatus
  autocmd!
  autocmd User ALEJobStarted call lightline#update()
  autocmd User ALELintPost call lightline#update()
  autocmd User ALEFixPost call lightline#update()
augroup END

