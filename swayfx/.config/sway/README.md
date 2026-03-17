# SwayFX

## Dependencies

The whole (or many) stack has changed because Wayland instead of X.
[migration_guide](https://github.com/swaywm/sway/wiki/i3-Migration-Guide)

- SwayFX - wm and compositor
- Kitty - replace xSt
- Imv - images viewer, replace Feh
- Eww - widgets (instead of the Awesome WM API)
- Swaybg
- wl-clipboard
- jq
- grim (screenshot), replace scrot
- Playerctl, mpd-mpris or mpdris2, mpv-mpris, mpc (needed to manage mpd
  playlists)
- ruby
- Brightnessctl, inotify-tools
- Thunar (optional)
- Neovim (optional) - replace Doom Emacs and vim
- Pinta (optional), replace Gimp.
- Dunst - Notification.
- imagemagick - Convert all images used by Eww

### Arch Linux

    sudo pacman -Syy \
    inotify-tools imv jq wl-clipboard curl stow \
    bc imagemagick rubygems grim swaybg wmenu rust \
    playerctl mpv-mpris kitty \
    git meson scdoc wayland-protocols cairo gdk-pixbuf2 \
    libevdev libinput json-c libgudev wayland libxcb \
    libxkbcommon pango pcre2 wlroots0.19 brightnessctl \
    libdrm libglvnd pixman glslang meson ninja \
    cargo libdbusmenu-gtk3 gtk3 gtk-layer-shell \
    iwd thunar dunst chafa swayidle swaylock wlr-randr \
    kew glances bulletty element-desktop wiremix \
    pipewire pipewire-alsa wireplumber

From AUR:

    scenefx swayfx eww

Before installing `eww` from AUR, you need to import GPG key:

    curl -sS https://github.com/elkowar.gpg | gpg --import
    curl -sS https://github.com/web-flow.gpg | gpg --import

Enable some user services for pipewire:

    systemctl --user enable pipewire
    systemctl --user enable wireplumber
    systemctl --user start pipewire
    systemctl --user start wireplumber

### Void Linux

Install your
[graphic driver](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html)
first. e.g for intel:

    sudo xbps-install -S linux-firmware-intel mesa-dri intel-video-accel

SwayFX dependencies

    sudo xbps-install -S swayfx imv jq wl-clipboard \
    inotify-tools kitty curl chafa cargo \
    stow playerctl mpv-mpris eww ruby swaybg grim \
    wmenu iwd Thunar elogind dunst ImageMagick \
    swayidle swaylock wlr-randr brightnessctl \
    kew glances element-desktop \
    pipewire alsa-pipewire wireplumber wireplumber-elogind

Required step as root

    ln -s /etc/sv/dbus /var/service
    ln -s /etc/sv/elogind /var/service

And the ALSA integration:

    mkdir -p /etc/alsa/conf.d
    ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
    ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

And enable pipewire per-user
[doc](https://docs.voidlinux.org/config/media/pipewire.html?highlight=pipewi#pipewire):

    $ mkdir -p "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d"
    $ ln -s /usr/share/examples/wireplumber/10-wireplumber.conf "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d/"

### Gentoo

You will need to activate [GURU](https://github.com/gentoo/guru)

    sudo emerge -av app-eselect/eselect-repository
    sudo eselect repository add guru git https://github.com/gentoo/guru.git
    sudo emaint sync -r guru

And install packages:

    sudo emerge -av net-misc/curl stow app-text/zathura \
    xfce-base/thunar media-gfx/chafa app-misc/brightnessctl \
    inotify-tools swaybg imv app-misc/jq sys-apps/fd \
    dev-lang/ruby playerctl wl-clipboard x11-terms/kitty \
    gui-apps/grim gui-apps/wmenu net-wireless/iwd app-misc/yazi \
    gui-apps/eww gui-wm/swayfx mpv-mpris media-gfx/imagemagick \
    gui-apps/swaylock gui-apps/swayidle gui-apps/wlr-randr \
    media-sound/kew sys-process/glances net-im/element-desktop-bin \
    media-video/pipewire media-video/wireplumber sys-auth/rtkit

For non-systemd, ensure enabling the USE flag elogind before installing
packages:

    euse -E elogind
    euse -D systemd

Required step as root

    usermod -aG pipewire username
    usermod -rG audio username

For systemd, enable service for user like on Archlinux:

    systemctl --user enable pipewire
    systemctl --user enable wireplumber
    systemctl --user start pipewire
    systemctl --user start wireplumber

See on Gentoo [wiki](https://wiki.gentoo.org/wiki/Sway#Starting_Sway_manually)

### From Ruby

After the installation of the dependencies, you need to install 2 ruby gems
called [i3ipc](https://rubygems.org/gems/i3ipc) and
[reaver](https://rubygems.org/gems/reaver):

    gem install --user-install i3ipc reaver

## Cloning this repo

Copy this repository:

    git clone https://github.com/szorfein/dotfiles ~/.dotfiles

If you add my dotfiles in another place, edit your shell (see below)

## Configuration

### Shell

You have to add 5 lines in your shell `.bash_profile`, `.zprofile`, etc...

```sh
# Load eww_scale
[ -f "$HOME/.eww_scale" ] && source "$HOME/.eww_scale"

# Ruby Path
export GEM_HOME="$(gem env user_gemhome)"
export PATH="$PATH:$GEM_HOME/bin"

# Mpd music dir, you also have to configure mpd...
export MPD_MUSIC_DIR="$HOME/where-musics-are"

# Where Dotfiles are, if not ~/.dotfiles
export DOTFILES_DIR="$HOME/.dotfiles"
```

And reload your shell after that.

### Keyboard

Copy the keyboard layout example, modify the default 'us' if need.

    mkdir -p ~/.config/sway
    cp ~/.dotfiles/swayfx/.config/sway/kdb.example ~/.config/sway/keyboard

For a french keyboard for example, you need to change the default
`xkb_layout us`

```sh
# https://github.com/swaywm/sway/wiki#keyboard-layout
input type:keyboard {
  xkb_layout fr
}
```

And follow configurations for remap keyboard keys on the
[sway-wiki](https://github.com/swaywm/sway/wiki#locale-specific-configuration-tricks)

### Run test-dpi.sh

Configs need 2 files in `~/.eww_scale` and `~/.config/eww/_scale.scss` generated
with the script.

    ~/.dotfiles/swayfx/bin/test-dpi.sh 1366 768 11.6
    dp scale factor 0.8443388199535182

The script need 3 parameters to calculate your DPI:

- `$1` horizontal screen,
- `$2` vertical
- `$3` is the diagonal

### Interact with iwd

User need to be added in `network` or `wheel` group.

    usermod -aG network username

## Installation

Before using stow, make sure to backups all your personal files and move them in
a backup directory.

Using my script `stow.sh`, you'll need to install at least: `swayfx` and a
`swayfx-themes` (last is `abyss`).

    ~/.dotfiles/stow.sh --swayfx abyss

If you want a more complete command, you can also add `foot`, `zsh`, `neovim`,
`tmux`.

    ~/.dotfiles/stow.sh --purge --kitty --neovim --tmux --zsh --swayfx abyss

Use `--purge` if need to reinstall files as first argument. The theme you want
as last argument `--swayfx abyss`.

I recommend you to create an alias or function (for Fish) here for easy
reinstall, e.g for Zsh:

    alias reinstall_dots="~/.dotfiles/stow.sh --purge --kitty --neovim --tmux --zsh --swayfx abyss"

## Download other dependencies

After installing dotfiles with `stow.sh`, last step is to downloads all the
required files (wallpapers, fonts, GTK themes, icons, etc...) in one command,
thanks ([Reaver](https://geeksrepos.com/szorfein/reaver)):

    reaver

## Menu launcher

I use fsel with otter-launcher, unfortunately, there are not include in a lot of
Linux distribution. So you have to compile them with Rust and Cargo, just start
my script:

    ~/bin/compile-menu-launcher.sh

## Start

On Void Linux, you need to start SwayFX with: `exec dbus-run-session -- sway`

## Updates

Update the repo using `git pull`

    cd .dotfiles && git pull

Reinstall files with `stow.sh --purge` to reinstall new dotfiles.

    ~/.dotfiles/stow.sh --purge --kitty --swayfx holy
    reaver

### Create your own theme

Follow the guide to create your own theme.
https://szorfein.vercel.app/post/your-own-swayfx-theme

### Thanks lighten library using Material 3 with CSS

- https://github.com/w3teal/gmx.css or https://gmxcss.js.org/
- https://github.com/beercss/beercss or https://www.beercss.com/
