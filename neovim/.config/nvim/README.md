# Neovim

Custom config for Neovim in order to upgrade my older
[vim 8 configs](https://github.com/szorfein/dotfiles/tree/main/vim) and replace
[Doom Emacs](https://github.com/doomemacs/doomemacs) (very slow on Wayland and a
lots of features just don't work without Xwayland).

Config use [lazy.vim](https://lazy.folke.io/) to grab all the dependencies, so
you have nothing to do.

## Dependencies with linter for conform.nvim

- neovim
- fd (replace `find`, written in Rust)
- fzf
- tmux
- git
- prettier
- rubocop
- stylua
- shfmt

## Installation by Linux distribution

- Arch Linux:
  `sudo pacman -S neovim fd fzf tmux git prettier rubocop stylua shfmt bash-language-server lua-language-server ansible-lint`

## Plugins selection

- Syntax highlighting with
  [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- LSP with
  [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), only
  Lua, Ruby, Unix Shell for now, and
  [mason](https://github.com/williamboman/mason.nvim).
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs),
  [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) HTML, TypeScript
- Code formatter with [conform.nvim](https://github.com/stevearc/conform.nvim)
- Autocompletion with
  [blink.nvim](https://github.com/saghen/blink.cmpstallation.md)
- Snippets with [LuaSnip](https://github.com/L3MON4D3/LuaSnip) and
  [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- Session, Buffer (not power full like the Emacs buffer mode, but it's right) with
  [resession.nvim](https://github.com/stevearc/resession.nvim)

UI use:

- Top Bar with [heirline](https://github.com/rebelot/heirline.nvim) - replace
  lightline.vim, it's also more easy and fast to customize and don't need to create
  a palette of colors in vim script, thanks the
  [doc](https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md).
- Icons with [Web Devicons](https://github.com/nvim-tree/nvim-web-devicons)
- Picker, fuzzer with
  [snack.nvim](https://github.com/folke/snacks.nvim/tree/main), replace
  [dressing](https://github.com/stevearc/dressing.nvim),
  [fzf](https://github.com/ibhagwan/fzf-lua)
  [indent blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
- Colors use [catppuccin.nvim](https://github.com/catppuccin/nvim), very
  modular, we can change all the colors if need (what we do to match with my
  themes).
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim), replace vim-gitgutter

## Basic commands

Manage plugin (lazy.nvim):

    :Lazy
    :Lazy check
    :Lazy update
    :Lazy clean (clean disabled plugin)
    :Lazy sync (update and clean)

Language syntax highlighting (Treesitter):

    :TSInstall bash

Installing tool (for conform.nvim (code format), LSP):

    :Mason (see the list and install what you want)
    :MasonInstallAll (install all things enable here (very short list))

See all LSP config

    :help lspconfig-all

## Keyboard Shortcuts

Command abbreviations:

    C- -> Control
    M- -> Meta, ("Alt" on most keyboard)
    S- -> Shift
    s- -> Super (not Shift)
    SPC -> Space

Move:

- C-a: move begin line
- C-e: move end line
- l: move left
- r: move right
- C-l: move left, word by word
- C-r: move right, word by word
- C-j: move line down
- C-k: move line up

Search file, buffer, session:

- C-x C-f: find (open) a file
- C-x b: switch buffer
- C-x s: save buffer
- C-x k: kill (close) buffer

Search keyboard shortcuts (WhichKey):

- C-h b: display all shortcuts

## Troubleshooting

#### Error during update (check out failed or any error related to git...)

Remove the concerned plugin from e.g:
`rm -rf ~/.local/share/nvim/lazy/<plugin-name>` Run `:Lazy` on Neovim to reinstall
the plugin.

#### No highlight color on your programming language

You probably need to install manually one from Treesitter, for example for
installing Bash in Neovim, type:

    :TSInstall bash

After the installation, relaunch your script to have the highlight enabled.

## Inspiration

- https://github.com/AstroNvim/AstroNvim
- https://github.com/NvChad/NvChad
- https://github.com/LazyVim/starter/tree/main
- https://code.x-e.ro/dotfiles

Also from books:

- Mastering Vim by Ruslan Osipov
- Mastering Emacs by Mickey Petersen
