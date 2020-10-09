## Setup

```txt                              
bar               > awesome
compositor        > picom
fonts             > iosevka nerd font,material-icons,ttf-anka-coder
image viewer      > feh
irc               > weechat
multimedia        > mpv,ncmpcpp,mpc,alsa
program launcher  > awesome
PDF viewer        > zathura
terms             > xst
wm                > awesome
mails             > offlineimap,msmtp and neomutt
```
A list of dependendies can be found [here](https://raw.githubusercontent.com/szorfein/dotfiles/master/hidden-stuff/dependencies-list.txt) if need. For an old wallpaper, search [here](https://raw.githubusercontent.com/szorfein/dotfiles/master/hidden-stuff/wallpapers-list.txt).

## Table of contents
- [installation](#installation-for-the-last-theme)
- [use stow](#howto-stow)
- [vim](#vim)
- [shell](#shell)
- [wallpapers](#wallpapers)
- [fonts](#fonts)
- [screenshots](#screens)
- [support](#support)

## Installation for the last theme
There are two way to install the last [themes/lines](#screens)
+ Fully scripted with [chezmoi](https://www.chezmoi.io/), follow the instruction [here](https://github.com/szorfein/dots).
+ Or manually by following the [wiki page](https://github.com/szorfein/dotfiles/wiki/theme-awesome).

The method with `chezmoi` only work with a theme for `awesomewm` and only for supported distrib Gentoo, Archlinux or Debian.  
You can try on other distributions like Centos, Ubuntu... at your own risk and peril :)

## Stow
If you are blocked with `stow` or need more explanations, see the [wiki page](https://github.com/szorfein/dotfiles/wiki/stow) before post an issue.  

## Vim
Here all the vim plugins i use:

| name | description | name | description
| --- | --- | --- | --- |
|[ale](https://github.com/w0rp/ale) | asynchronous check |[vim-devicons](https://github.com/ryanoasis/vim-devicons) | add icon to vim |
|[colorizer](https://github.com/lilydjwg/colorizer) | colorize hexa code |[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | used with tmux |
|[indentLine](https://github.com/Yggdroot/indentLine) | display indentation level |[nerdtree](https://github.com/scrooloose/nerdtree) | tree explorer |
|[lightline](https://github.com/itchyny/lightline.vim) | top, bottom bar |[vim-gitgutter](https://github.com/airblade/vim-gitgutter) | git diff in sign column |[nerdtree](https://github.com/scrooloose/nerdtree) | tree explorer |
|[lightline-bufferline](https://github.com/mengelbrecht/lightline-bufferline) | extend lightline | | |

#### On gentoo (with [ninjatools](https://github.com/szorfein/ninjatools)):
    sudo emerge -av app-vim/lightline gitgutter nerdtree pathogen app-vim/ale vim-devicons app-vim/colorizer vim-tmux-navigator indentline lightline-bufferline

#### And for all the vim colorscheme i use, with pathogen
    ./install --vim

## Shell
For the shell, i use `zsh` with plugins [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt).  
You can install theses repos with:

    ./install --zsh

## Wallpapers
To recover all the wallpapers i used, you need to install `wget` and execute a:

    ./install --images

You have to launch this each time a new theme come.  
It's all for the setup :)

## Fonts
For awesomewm, i use [Iosevka Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka), [SpaceMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SpaceMono) and [Material Design Icons Desktop](https://github.com/Templarian/MaterialDesign-Font).  
To install all the fonts (in `~/.local/share/fonts`), you can use my script too, for archlinux, you may prefer the install with AUR instead.

    ./install --fonts

## Screens

### Awm

**Last**:`themes/lines` **term**: xst, **vim-color**: [vamp](https://github.com/szorfein/vamp.vim), **font**: [Iosevka Term Nerd Font](http://nerdfonts.com/#downloads).

![lines screenshot](https://github.com/szorfein/unix-portfolio/raw/master/lines/monitor.png)
![lines 2](https://github.com/szorfein/unix-portfolio/raw/master/lines/full.png)
![lines 3](https://github.com/szorfein/unix-portfolio/raw/master/lines/start-screen.png)

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
![Lost screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/lost.jpg "lost")  

`themes/sombra` [term]: *kitty* [vim-color] [material.vim](https://github.com/kaicataldo/material.vim.git), [font] [Anka/Coder](https://code.google.com/archive/p/anka-coder-fonts).   
![Sombra screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/sombra.jpg "sombra")  

### i3wm

`themes/city`, [wm]: *i3* or *subtle*. [term]: *termite* or *kitty*. [vim-color] [darkest-space](https://github.com/szorfein/darkest-space)
![City screenshot](https://raw.githubusercontent.com/szorfein/dotfiles/master/screenshots/city.jpg "city")

### Other screenshots
More screenshots are available at [unix-portfolio](https://github.com/szorfein/unix-portfolio).

#### Support
Any support will be greatly appreciated, star the repo, a coffee, donation, thanks you !

[![Donate](https://img.shields.io/badge/don-liberapay-1ba9a4)](https://liberapay.com/szorfein) [![Donate](https://img.shields.io/badge/don-patreon-ab69f4)](https://www.patreon.com/szorfein)
