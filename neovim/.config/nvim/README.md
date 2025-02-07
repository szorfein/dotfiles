# Nvim

Custom config for Neovim in order to upgrade my own simple [vim configs](https://github.com/szorfein/dotfiles/tree/main/vim) and replace [Doomemacs](https://github.com/doomemacs/doomemacs) (very slow on Wayland and a lots of features just don't work without xwayland).

Config use [lazy.vim](https://lazy.folke.io/) to grab all the dependencies, so you have nothing to do.

## Dependencies

+ Neovim
+ fd (replace `find`, written in Rust)
+ fzf
+ tmux
+ git

## Plugins selection

+ [nvim-treesitter](https://github.com/nvim-treesitter)
+ [nvim-autopairs](https://github.com/windwp/nvim-autopairs), essential.
+ [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) autopairs for html, tsx
+ [gitsigns](https://github.com/lewis6991/gitsigns.nvim), replace vim-gitgutter
+ [heirline](https://github.com/rebelot/heirline.nvim) - replace lightline, it's also more easy and fast to customize and don't need to create a palette of colors in vim script, thanks the [doc](https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md).
+ [fzf.nvim](https://github.com/ibhagwan/fzf-lua) - I don't have try telescope yet but i don't need feature like file preview. Just need a fast and minimal fuzzy finder. Fzf also works with tmux.
+ [catppuccin.nvim](https://github.com/catppuccin/nvim), enought good, but also very modular, we can change all the colors if need (what we do to match with my themes).

Not very essential, purely to improve the UI:
+ [dressing](https://github.com/stevearc/dressing.nvim)
+ [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), replace vim-devicons.

## Shortcuts

...

## Inspiration

- https://github.com/AstroNvim/AstroNvim
- https://github.com/elenapan/dotfiles/tree/master/config/nvim

Also from books:
- Mastering Vim by Ruslan Osipov
