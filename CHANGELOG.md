## v5.0.0 - Abyss - Dec. 1 2025

#### Global change

- Add Gtk-3, Gtk-4 colorscheme
- Move awesome-m3 dots on separate branch
  https://github.com/szorfein/dotfiles/tree/focus-2.0.0
- Replace [NNN](https://github.com/jarun/nnn) by
  [Yazi](https://github.com/sxyazi/yazi)
- Use IosevkaTermSlab on Foot instead of IosevkaTerm
- Change terminal WezTerm by Foot

#### Sway - EWW

- New Blue/Cyan theme - Abyss
- Different colors for button-groups and icon-button
- More buttons on music player
- Convert all images used by EWW at start (help for default image cover album,
  changetheme)
- Change app launcher wmenu by
  [otter-launcher](https://github.com/kuokuo123/otter-launcher) +
  [fsel](https://github.com/Mjoyufull/fsel)
- Add lock screen with Swaylock and a custom version of
  [Swaylock-fancy](https://github.com/Big-B/swaylock-fancy/tree/main)
- EWW multi screens

#### Neovim

- More plugins with Mason, Neovim-LSP, Whichkey,
  [Zettel](https://github.com/michal-h21/vim-zettel), Trouble.
- Use
  [Snack.picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
  instead of lua-fzf
- More LSP enabled with [codebook](https://github.com/blopker/codebook),
  [bashls](https://github.com/bash-lsp/bash-language-server),
  [luals](https://github.com/luals/lua-language-server),
  [rubocop](https://github.com/rubocop/rubocop).
- More Emacs shortcuts
- Remove [resession](https://github.com/stevearc/resession.nvim) and use native
  mksession with [persistence](https://github.com/folke/persistence.nvim).

#### Bugs Fix

- Use conditional winbar (Heirline) for unwanted buffer/window list.
- Use imagemagick to convert cover album image, image too big has a HUGE
  performance impact on EWW.
- Correct all eww/daemons,scripts (thanks shellcheck). Make them compatible with
  Dash (for Void Linux) when possible or specify the use of /usr/bin/env bash.
- Downgrade fsel version (1.1.0) to be able to compile on voidlinux.

## v4.0.0 - Jinx - Oct 17 2025

#### Global change

The repo contain a lot of lua files, so i include configuration for linter
[stylua.toml](https://github.com/szorfein/dotfiles/blob/main/stylua.toml) (lua)
and [.prettierrc](https://github.com/szorfein/dotfiles/blob/main/.prettierrc)
(json, markdown, yaml, css)

#### Sway - EWW

- New SwayFX theme.
- Add notification with Dunst for SwayFX.
- Rewrite the last sidebar windows (network).
- New logout screen with basic action 'poweroff', 'hibernate', 'quit Sway' and
  'lock screen'.
- New changetheme widget (dialog), can switch between Holy and Jinx.
- New set of icons widgets from
  [m3 button-groups](https://m3.material.io/components/button-groups)

#### Neovim

- Add shfmt to format shell script.
- Add [snacks.nvim](https://github.com/folke/snacks.nvim)
- Add [blink.nvim](https://github.com/Saghen/blink.nvim)
- Add [luasnip](https://github.com/L3MON4D3/LuaSnip)
- Remove [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- Remove
  [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)

#### Bugs Fix

- tmux: remove default-terminal on Wayland, cause many bugs when (tmux-256color)
  not present and separate configs for X and Wayland.
- zsh: force the load of .zshenv (not loaded before on Gentoo...)
- zshenv: check if command exist before setting variables.
- Correct eww variable wifi-ssids
- Playerctl can works also with firefox, brave, mpd, mpv.

## Dotfiles Reorg.- Sep 28 2025

- dropped vim 8 configuration...
- dropped vifm configuration...
- move bin/ scripts into zsh/
- rename themes-m3 - awesome-m3-themes
- rename themes - awesome-m2-themes
- move older i3, subtle configs to hidden_stuff/

## Holy v3.2.0 - May 10 2025

- Add a colorscheme for Holy (terminals app)
- Add configuration for [foot](https://codeberg.org/dnkl/foot)

### Fixes

- picom glx errors on awesome startup

## Holy v3.0.0

### News

- Wayland with SwayFX (raise some old i3 themes?).
- Wrote widgets with [EWW](https://github.com/elkowar/eww).
- Add Tmux Plugins [catppuccin](https://github.com/catppuccin/tmux),
  [mode-indicator](https://github.com/MunifTanjim/tmux-mode-indicator).
- Add Neovim with LazyVim, add configs for
  [heirline](https://github.com/rebelot/heirline.nvim),
  [catppuccin.nvim](https://github.com/catppuccin/nvim),
  [fzf.lua](https://github.com/ibhagwan/fzf-lua) and many more...
- Add [Wezterm](https://wezfurlong.org/wezterm/index.html).
- Add [Reaver](https://github.com/szorfein/reaver) to downloads all stuff icons,
  fonts, wallpapers, plugins and more...
- Add `fzf` for Tmux and Neovim, see `v` aliase (zsh).
- `stow.sh` script, should make install and removal of stow links more easy.
- GTK-Theme generated with
  [oomox](https://github.com/themix-project/oomox-gtk-theme) for new themes.
- Nemo (replace vifm) and we also have `nnn` for Nerd.
- [playerctl](https://github.com/altdesktop/playerctl) MPRIS on top of mpd, mpc,
  mpv. Mitigate here since I don't use spotify or any other web service for
  music but we'll see...

### Updated

- zsh, tmux now support wayland.

### Dropped

- `install` script, replaced by reaver and yaml files.
- `vifm` configs (ueberzug no longer maintained).

## v2.0.5 - December 2024

- New Doom Emacs colorscheme (vamp)
- Update awm-m3/picom
- Update bin/ydl script to convert thumb in jpg (default convert in webp).
- Remove vifm/bin, new option to install `./install --vifm`.
- Use `kill -s USR1` instead of `kill -USR1`, compatibility POSIX shell.
- Font Iosevka and IosevkaTerm (missed) update to the v3.2.1 (was 2.1.0).

## Focus v2.0.0 - September 2024

New theme Focus, for the install, see
[here](https://github.com/szorfein/dotfiles/tree/main/awm-m3/.config/awesome).

### News

- New awesome configs based on spec of [Material 3](https://m3.material.io).
- New config are in `awm-m3`, themes comptatible are now in `themes-m3` folder.
- Add 6 themes in
  [themes-m3](https://github.com/szorfein/dotfiles/tree/main/themes-m3) - Focus
  (new), Lines, Morpho, Miami, Sci, Connected (resurrect for green tone).
- All colors has been remade to support Material 3 and their
  [Design Token](https://m3.material.io/foundations/design-tokens/overview).
- Vim (and lightline) colorschemes are pushed on
  [vamp.vim](https://github.com/szorfein/vamp.vim), based on Dracula (5000+
  lines of codes generated).
- Write a script to generate themes
  [new-theme-m3-maker.sh](https://github.com/szorfein/dotfiles/blob/main/awm-m3/bin/new-theme-m3-maker.sh),
  works with
  [material-theme-builder](https://material-foundation.github.io/material-theme-builder/).
- Add colors for Doom Emacs, you need to edit `~/.config/doom/config.el` and add
  `(setq doom-theme 'doom-shadow)` to load the theme.

### Updated

- ZSH now include [starship](https://starship.rs/) -
  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) -
  [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions) with
  ohmyzsh.
- New plugins enabled on ohmyzsh -
  [see more](https://github.com/szorfein/dotfiles/blob/main/zsh/.zshrc)
- Vim now support true colors.
- The [install script](https://github.com/szorfein/dotfiles/blob/main/install).

### Dropped

- [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt)
