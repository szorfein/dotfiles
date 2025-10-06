# Nvim

Custom config for Neovim in order to upgrade my older
[vim8 configs](https://github.com/szorfein/dotfiles/tree/main/vim) and replace
[Doomemacs](https://github.com/doomemacs/doomemacs) (very slow on Wayland and a
lots of features just don't work without xwayland).

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

## Installation per distros

- Archlinux: `sudo pacman -S neovim fd fzf tmux git prettier rubocop stylua`

## Plugins selection

- Syntax highlighting with
  [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs), essential.
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) autopairs for
  html, tsx
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim), replace vim-gitgutter
- [heirline](https://github.com/rebelot/heirline.nvim) - replace lightline, it's
  also more easy and fast to customize and don't need to create a palette of
  colors in vim script, thanks the
  [doc](https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md).
- [fzf-lua.nvim](https://github.com/ibhagwan/fzf-lua) - I don't have try
  telescope yet but i don't need feature like file preview. Just need a fast and
  minimal fuzzy finder. Fzf also works with tmux.
- [catppuccin.nvim](https://github.com/catppuccin/nvim), very modular, we can
  change all the colors if need (what we do to match with my themes).
- Code formatter with [conform.nvim](https://github.com/stevearc/conform.nvim)
- Autocompletion with
  [blink.nvim](https://github.com/saghen/blink.cmpstallation.md)
- Snippets with [LuaSnip](https://github.com/L3MON4D3/LuaSnip) and
  [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [snack.nvim](https://github.com/folke/snacks.nvim/tree/main), replace
  [dressing](https://github.com/stevearc/dressing.nvim),
  [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), replace
  vim-devicons.

## Shortcuts

...

## Troubleshooting

#### Error during update (checkout failed or any error related to git...)

Remove the concerned plugin from e.g:
`rm -rf ~/.local/share/nvim/lazy/<plugin-name>` Run `:Lazy` on nvim to reinstall
the plugin.

#### No highlight color on your programming language

You probably need to install manually one from treesitter, for example for
installing bash in nvim, type:

    :TSInstall bash

After the installation, relaunch your script to have the highlight enabled.

## Inspiration

- https://github.com/AstroNvim/AstroNvim
- https://github.com/NvChad/NvChad
- https://github.com/elenapan/dotfiles/tree/master/config/nvim
- https://github.com/LazyVim/starter/tree/main

Also from books:

- Mastering Vim by Ruslan Osipov
