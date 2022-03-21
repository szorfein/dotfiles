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

- **WM:** Awesome
- **OS:** Void or Gentoo MUSL, installed with [Getch](https://github.com/szorfein/getch)
- **SH:** ZSH with [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and [spaceship-prompt](https://spaceship-prompt.sh/)
- **Term:** xSt
- **Editor:** Vim8 and Doom-Emacs
- **Compositor:** Picom
- **File Manager:** FFF, vifm
- **Fonts:** [Nerd Font](https://www.nerdfonts.com/) (Iosevka) and (SpaceMono) + [Material Icons](https://github.com/Templarian/MaterialDesign-Font)

 ## Setup

### Installation for the last theme
There are two way to install the last [themes/lines](#screens)
+ Fully scripted with [chezmoi](https://www.chezmoi.io/), (better on a new install),  follow the instruction [here](https://github.com/szorfein/dots).
+ Or manually by following the [wiki page](https://github.com/szorfein/dotfiles/wiki/theme-awesome).

The method with `chezmoi` only work with supported distrib Gentoo, Archlinux, VoidLinux or Debian.  
You can try on other distro variant like Centos, Ubuntu... at your own risk and peril :)

### Vim
Here is a list of all the vim plugins i use: https://github.com/szorfein/dotfiles/wiki/Dependencies#vim

To install `vim.plug` and all plugins

    ./install --vim
    stow vim

### Shell
For the shell, i use `zsh` with plugins [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt).  
You can install theses repos with:

    ./install --zsh
    stow zsh

### Wallpapers
To recover all the wallpapers i use, you need to install `wget` and execute a:

    ./install --images

Or search directly [here](https://github.com/szorfein/walls). You have to launch this each time a new theme come.  

### Fonts
I use [Iosevka Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka), [SpaceMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SpaceMono) and [Material Design Icons Desktop](https://github.com/Templarian/MaterialDesign-Font).  
To install all the fonts (in `~/.local/share/fonts`), you can use my script too, for archlinux, you may prefer the install with AUR instead.

    ./install --fonts

## Screenshots

`themes/morpho` 

| clean |
| --- |
| ![clean](https://github.com/szorfein/unix-portfolio/raw/master/morpho/clean.png "morpho clean") |

`themes/miami` 

| terms (xst) - lightline.vim - tmux |
| --- |
| ![miami screenshot](https://github.com/szorfein/unix-portfolio/raw/master/miami/terms.png "Miami") |

### Other screenshots
More screenshots are available at [unix-portfolio](https://github.com/szorfein/unix-portfolio).

#### Support
Any support will be greatly appreciated, star the repo, a coffee, donation, thanks you !

[![Donate](https://img.shields.io/badge/don-liberapay-1ba9a4)](https://liberapay.com/szorfein) [![Donate](https://img.shields.io/badge/don-patreon-ab69f4)](https://www.patreon.com/szorfein)
