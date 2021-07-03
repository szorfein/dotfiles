"
"    ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄  
"   ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█  
"    ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄ 
"     ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"      ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"      ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"      ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒   
"        ░░   ▒ ░░      ░     ░░   ░ ░        
"         ░   ░         ░      ░     ░ ░      


call plug#begin()

" Colors
Plug 'szorfein/fromthehell.vim'
Plug 'szorfein/lightline.vim'
Plug 'szorfein/sci.vim'
Plug 'szorfein/vamp.vim'
Plug 'szorfein/ombre.vim'

" Plugins
Plug 'edkolev/tmuxline.vim'
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Visual Setting
set number

" Encoding
set ttyfast
set binary

" Tabs, May be overwritten by autocmd rules
" tips: https://codefaster.substack.com/p/fast-typing-vi
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType ruby setlocal ts=2 sts=2 sw=2
autocmd FileType python setlocal ts=4 sts=4 sw=4

" Add a showbreak character when line wrapping long time
set showbreak=↪\ 

" Explicitly render different types of whitespace differently
" and render trailing spaces.
set list listchars=tab:→\ ,nbsp:␣,trail:•

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
else
  set autoindent    " always set autoindenting on
endif " has("autocmd")

let mapleader=","
" Copy in Normal mode to xclip
nmap <leader>y "+yE
" Copy in Visual mode to xclip
vmap <leader>y "+y

" for vim 8
if (has("termguicolors"))
  "set notermguicolors t_Co=16

  " This is only necessary if you use "set termguicolors".
  "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Colors
source ~/.vim/colorscheme

" Plugins
source ~/.vim/plugin-configs.vim

" If there are a custom lightline setting by theme
let x = "~/.vim/lightline-theme.vim"

if filereadable(expand(x))
  execute 'source' x
endif
