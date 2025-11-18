set nocompatible
filetype plugin indent on
syntax on

" Relative line number
set number relativenumber

set autoindent " copy indent from the previous line
set autoread " reload from disk
set backspace=indent,eol,start " modern backspace behavior

set belloff=all " disable bell
set complete-=i " don't scan current on included

" Files for completions
set display=lastline,msgsep " display more msg text
set encoding=utf-8
set fillchars=vert:: " separator character

set formatoptions=tcqj " autoformatting
set fsync " robust file saving
set history=10000 " maximum
set hlsearch " highlight search results
set incsearch " move cursor as you type wh searching
set langnoremap " helps avoid mappings breaking

" hide bottom bar completly
set laststatus=0 " hide status line, =2 to display
set noshowmode
"set noshowcmd
set noruler

set listchars=tab:>\ ,trail:-,nbsp:+ " char for :list
set nrformats=bin,hex " <c-a> and <c-x> support
"set ruler " display current line # in corner
set sessionoptions-=options " do not carry options accross session
"set shortmess=F " less verbose file info
set showcmd " show last command in status line
set sidescroll=1
set smarttab " tab setting aware <Tab> key

set tabpagemax=50 " max number of tabs open by -p flag
set tags=./tags;,tags " filename to look for tags
set ttimeoutlen=50 " ms to wait for next key in sequence
set ttyfast
set viminfo+=! " save global variables accross session
set wildmenu " enhance command line completion

" Use system clipboard
set clipboard=unnamedplus

" netrw config (:Vexplore)
let g:netrw_browse_split = 0
let g:netrw_altfile = 1

" Indentation
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
set smartindent
set cindent

" Shell
set shell=/bin/zsh

" Shortcuts

" Few Emacs shorcuts
" https://caiorss.github.io/Emacs-Elisp-Programming/Keybindings.html
"nmap <C-x>s :w<cr>
"nmap <C-x><C-f> :FzfLua files<cr>
"nmap <C-x>c :wq<cr> " should be <C-x><C-c> but not works

" Load custom theme when installed
" (colorscheme + lightline)
" if filereadable(glob("~/.config/nvim/theme.vim"))
"   execute 'source' '~/.config/nvim/theme.vim'
"endif

lua require('configs.lazy')
lua require('configs.autocmds')
lua require('configs.commands')

" Colours
syntax enable
" lightline before
"let g:lightline = {'colorscheme': 'catppuccin'}
colorscheme catppuccin
