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
  `sudo pacman -S neovim fd fzf tmux git prettier rubocop stylua shfmt bash-language-server lua-language-server ansible-lint`

## Plugins selection

- Language Server Protocol with [Native LSP](https://github.com/neovim/nvim-lspconfig). Only Lua, Ruby, Unix Shell for now.
- Fuzzy finding with [Snacks Picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
- Code formatter with [Conform](https://github.com/stevearc/conform.nvim)
- Autocompletion with
  [blink.nvim](https://github.com/saghen/blink.cmpstallation.md)
- Colors use [Catppuccin](https://github.com/catppuccin/nvim), very
  modular, we can change all the colors if need (what we do to match with my
  themes).
- Top Bar with [heirline](https://github.com/rebelot/heirline.nvim) - replace
  lightline, it's also more easy and fast to customize and don't need to create
  a palette of colors in vim script, thanks the
  [doc](https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md).

Look under lua/ui and lua/plugins to see all plugins activated.

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
- M-l: move left, word by word
- M-r: move right, word by word
- C-j: move line down
- C-k: move line up

Search file, buffer, session:

- C-x C-f: find (open) a file
- C-x b: switch buffer
- C-x s: save buffer
- C-x k: kill (close) buffer

`C-h` to display help:

- C-h b: display all keybinds (whichkey)

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
- https://github.com/LazyVim/starter/tree/main
- https://code.x-e.ro/dotfiles

Also from books:

- Mastering Vim by Ruslan Osipov
- Mastering Emacs by Mickey Petersen
