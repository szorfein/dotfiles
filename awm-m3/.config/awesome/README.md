# Awesome M3

Minimal implementation of the [material guide](https://m3.material.io/) for AwesomeWM.

+ Use [Design-Token](https://m3.material.io/foundations/design-tokens/overview)
+ Support only dark theme.
+ Colors are designed to meet accessibility standards for color contrast.
+ Shell scripts comptatible with `/bin/dash`.
+ Lighten WM, consume around 170Mb of memory.
+ Can works with [Musl](https://musl.libc.org/about.html)
+ Auto-lock with xss-lock and betterlockscreen.
+ Easy to create your own theme (soon tell u how...:))

## Dependencies

| Roles | Requirements |
|---|---|
| WM | Last release of [Awesome](https://github.com/awesomeWM/awesome) |
| Font | Iosevka from [Nerd font](https://github.com/ryanoasis/nerd-fonts) |
| Icon Font | [Material Icon Desktop](https://github.com/Templarian/MaterialDesign-Font) |
| Compositor | [Picom](https://github.com/yshui/picom) |
| Brightness | [Light](https://github.com/haikarainen/light) |
| Music Player | [MPD](https://www.musicpd.org/) controlled by [mpc](https://www.musicpd.org/clients/mpc/) |
| Sound | Work with [ALSA](https://www.alsa-project.org/main/index.php/Main_Page) or [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) |
| ACPI | [acpid 2](https://sourceforge.net/projects/acpid2/) |
| Remote Watch | [Curl](https://curl.haxx.se) |
| JSON Parser | [jq](https://github.com/stedolan/jq) |
| Lock Screen | [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen) with [xss-lock](https://bitbucket.org/raymonad/xss-lock) |
| Screenshot | [Maim](https://github.com/naelstrof/maim) |

### Archlinux

    sudo pacman -Syy awesome picom feh papirus-icon-theme \
    xss-lock inotify-tools maim jq mpd mpc xorg-server xorg-xinit \
    xclip xf86-input-libinput curl stow xcb-util-image pam libev \
    cairo libxkbcommon-x11 libjpeg-turbo xcb-util-xrm pkgconf \
    bc imagemagick xorg-xdpyinfo xorg-xrandr

And from [AUR](https://aur.archlinux.org/): `i3lock-color betterlockscreen xst light`

### Voidlinux

    sudo xbps-install -S awesome picom feh light papirus-icon-theme \
    xss-lock inotify-tools maim i3lock-color betterlockscreen \
    jq mpd mpc xorg-minimal xinit xclip xrdb gcc xorg-input-drivers \
    xst curl stow

### Gentoo
You will need to add my repository: https://github.com/szorfein/ninjatools and GURU: https://github.com/gentoo/guru

    sudo emerge -av awesome picom feh light papirus-icon-theme \
    xss-lock inotify-tools maim x11-misc/betterlockscreen \
    app-misc/jq media-sound/mpd media-sound/mpc xorg-server \
    xinit x11-misc/xclip xf86-input-libinput xst curl stow

## Backup your dotfiles
You can create a directory e.g `backup` and move all the files which can conflict with my files.

## Clone the repo

    git clone https://github.com/szorfein/dotfiles ~/.dotfiles

Many files from my `awesome` will look for `~/.dotfiles`, so be sure to copy to the right place.

## Install the config files with Stow
Last theme is 'focus'.

    cd ~/.dotfiles
    ./stow.sh --purge --awm-m3 focus

More complete command, adapt with your need:

    ./stow.sh --purge --doom --awm-m3 focus --zsh --ncmpcpp --vim

## Install the fonts, wallpapers required
You probably have to install ruby with ruby-gem

    gem install --user-install reaver
    reaver

## Update

    cd ~/.dotfiles
    git pull

Reinstall all stow configs you use

    ./stow.sh --purge --awm-m3 current-theme-name

And reaver to grab the last packages.

    reaver

Enjoy
