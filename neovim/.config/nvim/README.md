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
- shfmt

## Installation per distros

- Archlinux:
  `sudo pacman -S neovim fd fzf tmux git prettier rubocop stylua shfmt`

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

## Basic commands

Manage plugin (lazy.nvim):

    :Lazy
    :Lazy check
    :Lazy update
    :Lazy clean (clean disabled plugin)
    :Lazy sync (update and clean)

Language syntax highligh (treesitter):

    :TSInstall bash

Installing tool (for conform.nvim (code format), lsp):

    :Mason (see the list and install what you want)
    :MasonInstallAll (install all things enable here (very short list))

## Keyboard Shortcuts

Command abbreviations:

- C- -> Control
- M- -> Meta, ("Alt" on most keyboard)
- S- -> Shift
- s- -> Super (not Shift)
- SPC -> Space

Move:

- C-a: move begin line
- C-e: move end line

Search file:

- C-x C-f: find (open) a file

Will implement following shorcuts:

Basic:

ALL shortcuts bellow are not yet implemented, maybe in futur. A lot come from
Emacs.

- C-x C-s: save the buffer
- C-x C-w: save the buffer as
- C-x s: save all buffer (interactive ?)
- C-x b: switch buffer
- C-x k: kill (close) buffer
- C-x C-b: Display all open buffer
- C-x C-c: quit Neovim
- C-x u: undo

Minibuffer: where are display error message ? For session, search:

- https://github.com/rmagatti/auto-session
- https://github.com/stevearc/resession.nvim
- https://github.com/folke/persistence.nvim

Windows (I don't thing implement this like this)

- C-x 0: delete active window
- C-x 1: delete other window
- C-x 2: split window bellow (v)
- C-x 3: split window right (h)
- C-x o: Switch active window

Directional window move (like windmove package)

- S-<left>
- S-<right>
- S-<up>
- S-<down>

Move:

- <left>... Arrow key, move character by character
- C-<left>... Move word by word in the direction

Whichkey (help command on C-h)

- C-h w or C-h k
- C-h b: display all keybinds (true mode)

LSP: M-x server-start

Completing Word:

Manage bookmark and register (need a plugin -
https://github.com/tomasky/bookmarks.nvim ?)

- C-x r m: Set a bookmark
- C-x r l: List bookmark
- C-x r b: Jump to a bookmark

TAB completion

- TAB
- C-M-j or C-M-k: down or up
- C-n, C-p
- M-<: Begin completion list
- M->: End completion list

Indent (or align) a region , one of:

- C-M-\ and add the symbol for align, e.g: C-M-\ :
- C-x Tab: ?
- C-M-o: following by a symbol

Running one command

- M-!
- M-x shell Enter: create a shell in it's own buffer

Dired: ((see file hierarchy)

- C-x d: ((C-n go next, C-p prev, v preview))

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
- https://code.x-e.ro/dotfiles

Also from books:

- Mastering Vim by Ruslan Osipov
- Mastering Emacs by Mickey Petersen

### Keybinds Emacs

- https://github.com/sei40kr/nvimacs/blob/main/plugin/nvimacs.lua
- https://github.com/andrep/vimacs/blob/master/plugin/vimacs.vim
- https://github.com/tpope/vim-rsi/blob/master/plugin/rsi.vim
