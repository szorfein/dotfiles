- Remove vifm/bin, new option to install `./install --vifm`.
- Use `kill -s USR1` instead of `kill -USR1`, compatibility POSIX shell.
- Font Iosevka and IosevkaTerm (missed) update to the v3.2.1 (was 2.1.0).

## Focus v2.0.0 - September 2024
New theme Focus, for the install, see
[here](https://github.com/szorfein/dotfiles/tree/main/awm-m3/.config/awesome).

### News
- New awesome configs based on spec of [Material 3](https://m3.material.io).
- New config are in `awm-m3`, themes comptatible are now in `themes-m3` folder.
- Add 6 themes in [themes-m3](https://github.com/szorfein/dotfiles/tree/main/themes-m3) - Focus (new), Lines, Morpho, Miami, Sci, Connected (resurrect for green tone).
- All colors has been remade to support Material 3 and their [Design
  Token](https://m3.material.io/foundations/design-tokens/overview).
- Vim (and lightline) colorschemes are pushed on [vamp.vim](https://github.com/szorfein/vamp.vim), based on Dracula (5000+ lines of codes generated).
- Write a script to generate themes [new-theme-m3-maker.sh](https://github.com/szorfein/dotfiles/blob/main/awm-m3/bin/new-theme-m3-maker.sh), works with [material-theme-builder](https://material-foundation.github.io/material-theme-builder/).
- Add colors for doomemacs, you need to edit `~/.config/doom/config.el` and add
  `(setq doom-theme 'doom-shadow)` to load the theme.

### Updated
- ZSH now include [starship](https://starship.rs/) - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions) with ohmyzsh.
- New plugins enabled on ohmyzsh - [see
  more](https://github.com/szorfein/dotfiles/blob/main/zsh/.zshrc)
- Vim now support true colors.
- The [install script](https://github.com/szorfein/dotfiles/blob/main/install).

### Dropped
- [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt)
