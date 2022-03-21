<h2 align="center">x Custom dotfiles x</h2>
<p align="center">
<img alt="" src="https://badges.pufler.dev/visits/szorfein/dotfiles?style=flat-square&color=9a74f2&logoColor=white&labelColor=373e4d" />
<img alt="" src="https://img.shields.io/github/repo-size/szorfein/dotfiles?style=flat-square&label=Repo" />
</p>

<p align="center">
<img alt="" src="https://badges.pufler.dev/visits/szorfein/dotfiles?style=flat-square&color=9a74f2&logoColor=white&labelColor=373e4d" />

<img alt="" src="https://img.shields.io/github/repo-size/szorfein/dotfiles?style=flat-square&label=repo" />
</p>

<p align="center">
<a href="https://github.com/szorfein/dotfiles#setup">Setup</a>
| <a href="https://github.com/szorfein/dotfiles/wiki">Wiki</a> 
| <a href="https://github.com/szorfein/dotfiles/wiki/Gallery">Gallery</a>
| <a href="https://github.com/szorfein/dotfiles/wiki/Keybinds">Keybinds</a>
</p>

## Table of contents
- [installation](#installation-for-the-last-theme)
- [use stow](#howto-stow)
- [vim](#vim)
- [shell](#shell)
- [wallpapers](#wallpapers)
- [fonts](#fonts)
- [screenshots](#screenshots)
- [support](#support)

## Installation for the last theme
There are two way to install the last [themes/lines](#screens)
+ Fully scripted with [chezmoi](https://www.chezmoi.io/), (better on a new install),  follow the instruction [here](https://github.com/szorfein/dots).
+ Or manually by following the [wiki page](https://github.com/szorfein/dotfiles/wiki/theme-awesome).

The method with `chezmoi` only work with supported distrib Gentoo, Archlinux, VoidLinux or Debian.  
You can try on other distro variant like Centos, Ubuntu... at your own risk and peril :)

## Stow
If you are blocked with `stow` or need more explanations, see the [wiki page](https://github.com/szorfein/dotfiles/wiki/stow) before post an issue.  

## Vim
Here is a list of all the vim plugins i use: https://github.com/szorfein/dotfiles/wiki/Dependencies#vim

To install vim.plug and all plugins

    ./install --vim
    stow vim

## Shell
For the shell, i use `zsh` with plugins [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt).  
You can install theses repos with:

    ./install --zsh
    stow zsh

## Wallpapers
To recover all the wallpapers i use, you need to install `wget` and execute a:

    ./install --images

Or search directly [here](https://github.com/szorfein/walls). You have to launch this each time a new theme come.  

## Fonts
For awesomewm, i use [Iosevka Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka), [SpaceMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SpaceMono) and [Material Design Icons Desktop](https://github.com/Templarian/MaterialDesign-Font).  
To install all the fonts (in `~/.local/share/fonts`), you can use my script too, for archlinux, you may prefer the install with AUR instead.

    ./install --fonts

## Screenshots

### Awm

**Last**:`themes/lines` **term**: xst, **vim-color**: [vamp](https://github.com/szorfein/vamp.vim), **font**: [Iosevka Term Nerd Font](http://nerdfonts.com/#downloads).

![lines screenshot](https://github.com/szorfein/unix-portfolio/raw/master/lines/full.png)
![lines 2](https://github.com/szorfein/unix-portfolio/raw/master/lines/start-screen.png)

`themes/morpho` **term**: xst, **vim-color**: [darkest-space](https://github.com/szorfein/darkest-space), **font**: [Iosevka Term Nerd Font](http://nerdfonts.com/#downloads).

| clean |
| --- |
| ![clean](https://github.com/szorfein/unix-portfolio/raw/master/morpho/clean.png "morpho clean") |

`themes/miami` **term**: xst, **vim-color**: [fromthehell](https://github.com/szorfein/fromthehell.vim), **font**: [Space Mono Nerd Font](http://nerdfonts.com/#downloads).

| terms (xst) - lightline.vim - tmux |
| --- |
| ![miami screenshot](https://github.com/szorfein/unix-portfolio/raw/master/miami/terms.png "Miami") |

### Subtlewm

`themes/lost` [term]: *kitty* [vim-color] [OceanicNext](https://github.com/mhartington/oceanic-next), [font] [Nerd Roboto Mono](http://nerdfonts.com/#downloads).   
![Lost screenshot](https://raw.githubusercontent.com/wiki/szorfein/dotfiles/assets/lost.jpg "lost")  

`themes/sombra` [term]: *kitty* [vim-color] [material.vim](https://github.com/kaicataldo/material.vim.git), [font] [Anka/Coder](https://code.google.com/archive/p/anka-coder-fonts).   
![Sombra screenshot](https://raw.githubusercontent.com/wiki/szorfein/dotfiles/assets/sombra.jpg "sombra")  

### i3wm

`themes/city`, [wm]: *i3* or *subtle*. [term]: *termite* or *kitty*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space)
![City screenshot](https://raw.githubusercontent.com/wiki/szorfein/dotfiles/assets/city.jpg "city")

### Other screenshots
More screenshots are available at [unix-portfolio](https://github.com/szorfein/unix-portfolio).

#### Support
Any support will be greatly appreciated, star the repo, a coffee, donation, thanks you !

[![Donate](https://img.shields.io/badge/don-liberapay-1ba9a4)](https://liberapay.com/szorfein) [![Donate](https://img.shields.io/badge/don-patreon-ab69f4)](https://www.patreon.com/szorfein)
