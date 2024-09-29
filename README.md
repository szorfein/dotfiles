<h2 align="center">x Custom Dotfiles x</h2>
<p align="center">
<a href="https://github.com/szorfein/dotfiles/stargazers">
  <img src="https://img.shields.io/github/stars/szorfein/dotfiles?color=%23BB9AF7&labelColor=%231A1B26&style=for-the-badge">
</a>
<a href="https://github.com/szorfein/dotfiles/network/members/">
  <img src="https://img.shields.io/github/forks/szorfein/dotfiles?color=%237AA2F7&labelColor=%231A1B26&style=for-the-badge">
</a>
<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/szorfein/dotfiles?color=73daca&labelColor=%231A1B26&style=for-the-badge" />
<img alt="" src="https://img.shields.io/github/repo-size/szorfein/dotfiles?color=%230969da&labelColor=%231A1B26&style=for-the-badge&label=Repo" />
</p>

###

<p align="center">
<a href="https://github.com/szorfein/dotfiles#setup">Setup</a>
| <a href="https://github.com/szorfein/dotfiles/wiki">Wiki</a>
| <a href="https://github.com/szorfein/dotfiles/wiki/Keybinds">Keybinds</a>
| <a href="https://github.com/szorfein/dotfiles/wiki/Gallery">Gallery</a>
</p>

##

![focus screenshot](https://github.com/szorfein/unix-portfolio/raw/master/focus/clean.jpg)
![focus full](https://github.com/szorfein/unix-portfolio/raw/master/focus/full.jpg)

###

- **WM:** [Awesome](https://github.com/awesomeWM/awesome)
- **OS:** [Arch](https://archlinux.org/), [Void](https://voidlinux.org/) or [Gentoo](https://www.gentoo.org/) with [Musl](https://musl.libc.org/), installed with [Getch](https://github.com/szorfein/getch)
- **SH:** ZSH with [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and [starship](https://starship.rs)
- **Term:** [xSt](https://github.com/gnotclub/xst)
- **Editor:** [Vim](https://github.com/vim/vim) and [Doomemacs](https://github.com/doomemacs/doomemacs)
- **Compositor:** [Picom](https://github.com/yshui/picom)
- **File Manager:** [NNN](https://github.com/jarun/nnn), [Vifm](https://github.com/vifm/vifm)
- **Fonts:** [Nerd Font](https://www.nerdfonts.com/) Iosevka, SpaceMono + [Material Icons](https://github.com/Templarian/MaterialDesign-Font) + [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- **Dotfiles manager and theme switcher:** [GNU/Stow](https://www.gnu.org/software/stow/)

###

## Setup

### Installation for the last theme
There are three way to install the last [themes-m3/focus](#screens)
+ Manually by following the [wiki page](https://github.com/szorfein/dotfiles/tree/main/awm-m3/.config/awesome), works on any distribution and you install only what your need.
+ (Not Yet Tested on last theme) Fully scripted with [chezmoi](https://www.chezmoi.io/), (better on a new install), follow the instruction [here](https://github.com/szorfein/dots).
+ (Not Yet Tested on last theme) Ansible with
  [ansible-collection-desktop](https://github.com/szorfein/ansible-collection-desktop),
you can find an example of playbook
[here](https://github.com/szorfein/dots/tree/ansible/home/ansible).

The method with `chezmoi` and `ansible` only work for supported distrib Gentoo, Archlinux, Voidlinux or Debian (bulleyes).  

### Vim
For Vim, i use the native Vim8 package loading, to install all plugins, you need to install `git` and launch:

    cd ~/.dotfiles
    ./install --vim
    stow vim

### Shell
You can install [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and extensions with:

    cd ~/.dotfiles
    ./install --zsh
    stow zsh

You also need to install [starship](https://starship.rs/guide/#step-1-install-starship) from your package distribution or with cargo.

### Other themes

`themes/lines`  

| full |
|---|
| ![full](https://github.com/szorfein/unix-portfolio/raw/master/lines/full.png "lines full") |

`themes/morpho`  

| clean |
| --- |
| ![clean](https://github.com/szorfein/unix-portfolio/raw/master/morpho/clean.png "morpho clean") |

`themes/miami`  

| terms (xst) - lightline.vim - tmux |
| --- |
| ![miami screenshot](https://github.com/szorfein/unix-portfolio/raw/master/miami/terms.png "Miami") |

### Other screenshots
More screenshots are available at [unix-portfolio](https://github.com/szorfein/unix-portfolio) or [Gallery](https://github.com/szorfein/dotfiles/wiki/Gallery).

#### Support
Any support will be greatly appreciated, star the repo, a coffee, donation, thanks you !

[![Donate](https://img.shields.io/badge/don-liberapay-1ba9a4)](https://liberapay.com/szorfein) [![Donate](https://img.shields.io/badge/don-patreon-ab69f4)](https://www.patreon.com/szorfein)
