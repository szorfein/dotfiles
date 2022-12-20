<h2 align="center">x Custom Dotfiles x</h2>
<p align="center">
<a href="https://github.com/szorfein/dotfiles/stargazers">
  <img src="https://img.shields.io/github/stars/szorfein/dotfiles?color=%23BB9AF7&labelColor=%231A1B26&style=for-the-badge">
</a>
<a href="https://github.com/szorfein/dotfiles/network/members/">
  <img src="https://img.shields.io/github/forks/szorfein/dotfiles?color=%237AA2F7&labelColor=%231A1B26&style=for-the-badge">
</a>
<img src="https://badges.pufler.dev/visits/szorfein/dotfiles?style=for-the-badge&color=73daca&logoColor=white&labelColor=1A1B26" />
<img alt="" src="https://img.shields.io/github/repo-size/szorfein/dotfiles?style=for-the-badge&label=Repo" />
</p>

###

<p align="center">
<a href="https://github.com/szorfein/dotfiles#setup">Setup</a>
| <a href="https://github.com/szorfein/dotfiles/wiki">Wiki</a>
| <a href="https://github.com/szorfein/dotfiles/wiki/Keybinds">Keybinds</a>
| <a href="https://github.com/szorfein/dotfiles/wiki/Gallery">Gallery</a>
</p>

##

![lines screenshot](https://github.com/szorfein/unix-portfolio/raw/master/lines/full.png)
![lines 2](https://github.com/szorfein/unix-portfolio/raw/master/lines/start-screen.png)

###

- **WM:** [Awesome](https://github.com/awesomeWM/awesome)
- **OS:** [Void](https://voidlinux.org/) or [Gentoo](https://www.gentoo.org/) with [Musl](https://musl.libc.org/), installed with [Getch](https://github.com/szorfein/getch)
- **SH:** ZSH with [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and [spaceship-prompt](https://spaceship-prompt.sh/)
- **Term:** [xSt](https://github.com/gnotclub/xst)
- **Editor:** [Vim](https://github.com/vim/vim) and [Doom-Emacs](https://github.com/hlissner/doom-emacs)
- **Compositor:** [Picom](https://github.com/yshui/picom)
- **File Manager:** [FFF](https://github.com/dylanaraps/fff), [Vifm](https://github.com/vifm/vifm)
- **Fonts:** [Nerd Font](https://www.nerdfonts.com/) Iosevka, SpaceMono + [Material Icons](https://github.com/Templarian/MaterialDesign-Font) + [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- **Dotfiles manager and theme switcher:** [GNU/Stow](https://www.gnu.org/software/stow/)

###

## Setup

### Installation for the last theme
There are two way to install the last [themes/lines](#screens)
+ Fully scripted with [chezmoi](https://www.chezmoi.io/), (better on a new install),  follow the instruction [here](https://github.com/szorfein/dots).
+ Or manually by following the [wiki page](https://github.com/szorfein/dotfiles/wiki/theme-awesome).

The method with `chezmoi` only work with a theme for `awesomewm` and only for supported distrib Gentoo, Archlinux or Debian.  
You can try on other distributions like Ubuntu... at your own risk and peril :)

### Vim
For Vim, i use the native package loading, to install all plugins, you need to install `git` and launch:

    ./install --vim
    stow vim

### Shell
You can install [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt) with:

    ./install --zsh
    stow zsh

### Wallpapers
To recover all the wallpapers (the script will place them into `~/images`), you need to install `curl` and execute a:

    ./install --images

Or search directly [here](https://github.com/szorfein/walls). You have to launch this each time a new theme come.  

### Fonts 
To install all the fonts (in `~/.local/share/fonts`), you can use my script too.  

    ./install --fonts

### Other themes

`themes/morpho` 

| clean |
| --- |
| ![clean](https://github.com/szorfein/unix-portfolio/raw/master/morpho/clean.png "morpho clean") |

`themes/miami` 

| terms (xst) - lightline.vim - tmux |
| --- |
| ![miami screenshot](https://github.com/szorfein/unix-portfolio/raw/master/miami/terms.png "Miami") |

There are many themes under the folder `themes` but not all are compatible with Awesome yet.

### Other screenshots
More screenshots are available at [unix-portfolio](https://github.com/szorfein/unix-portfolio) or [Gallery](https://github.com/szorfein/dotfiles/wiki/Gallery).

#### Support
Any support will be greatly appreciated, star the repo, a coffee, donation, thanks you !

[![Donate](https://img.shields.io/badge/don-liberapay-1ba9a4)](https://liberapay.com/szorfein) [![Donate](https://img.shields.io/badge/don-patreon-ab69f4)](https://www.patreon.com/szorfein)
