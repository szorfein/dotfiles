# SwayFX

## Dependencies

The whole (or many) stack has changed because Wayland instead of X.
[migration_guide](https://github.com/swaywm/sway/wiki/i3-Migration-Guide)

- SwayFX - wm and compositor
- Foot - replace xSt
- Imv - images viewer, replace Feh
- Eww - widgets (instead of the Awesome WM API)
- Swaybg
- wl-clipboard
- jq
- grim (screenshot), replace scrot
- Playerctl, mpd-mpris or mpdris2, mpv-mpris, mpc (needed to manage mpd
  playlists)
- ruby
- Light, inotify-tools
- Thunar (optional)
- Neovim (optional) - replace Doom Emacs and vim
- Pinta (optional), replace Gimp.
- Dunst - Notification.
- imagemagick - Convert all images used by Eww

### Arch Linux

    sudo pacman -Syy \
    inotify-tools imv jq mpd mpc wl-clipboard curl stow \
    bc imagemagick rubygems grim swaybg wmenu rust \
    playerctl mpd-mpris mpv-mpris foot foot-terminfo \
    git meson scdoc wayland-protocols cairo gdk-pixbuf2 \
    libevdev libinput json-c libgudev wayland libxcb \
    libxkbcommon pango pcre2 wlroots0.19 seatd \
    libdrm libglvnd pixman glslang meson ninja \
    cargo libdbusmenu-gtk3 gtk3 gtk-layer-shell \
    iwd thunar dunst chafa swayidle swaylock wlr-randr

From AUR:

    scenefx swayfx eww light

Before installing `eww` from AUR, you need to import GPG key:

    curl -sS https://github.com/elkowar.gpg | gpg --import
    curl -sS https://github.com/web-flow.gpg | gpg --import

Required step as root

    usermod -aG seat username
    systemctl enable seatd
    systemctl start seatd

### Void Linux

Install your
[graphic driver](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html)
first. e.g for intel:

    sudo xbps-install -S linux-firmware-intel mesa-dri intel-video-accel

SwayFX dependencies

    sudo xbps-install -S swayfx imv light jq wl-clipboard \
    inotify-tools mpd mpc foot curl chafa cargo \
    stow playerctl mpv-mpris mpDris2 eww ruby swaybg grim \
    wmenu iwd Thunar seatd turnstile dunst ImageMagick \
    swayidle swaylock wlr-randr

Required step as root

    usermod -aG _seatd username
    ln -s /etc/sv/seatd /var/service
    ln -s /etc/sv/turnstiled /var/service

### Gentoo

You will need to activate [GURU](https://github.com/gentoo/guru)

    sudo emerge -av app-eselect/eselect-repository
    sudo eselect repository add guru git https://github.com/gentoo/guru.git
    sudo emaint sync -r guru

And install packages:

    sudo emerge -av light net-misc/curl stow
    xfce-base/thunar media-gfx/chafa \
    inotify-tools swaybg imv app-misc/jq \
    app-misc/jq media-sound/mpd media-sound/mpc \
    dev-lang/ruby playerctl wl-clipboard gui-apps/foot \
    gui-apps/grim gui-apps/wmenu net-wireless/iwd \
    gui-apps/eww gui-wm/swayfx mpv-mpris mpd-mpris \
    acct-group/seat seatd media-gfx/imagemagick \
    gui-apps/swaylock gui-apps/swayidle gui-apps/wlr-randr

> [!NOTE] seatd should be compiled with the `server` use flag

Required step as root

    usermod -aG seat username
    usermod -aG video username

And enable the `seatd` service, for `musl` you have to manually create
XDG_RUNTIME_DIR; add this into your `.zprofile` (or equivalent).

```sh
if test -z "${XDG_RUNTIME_DIR}"; then
  export XDG_RUNTIME_DIR=/tmp/"${UID}"-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi
```

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
`swayfx-themes` (last is `jinx`).

    ~/.dotfiles/stow.sh --swayfx jinx

If you want a more complete command, you can also add `foot`, `zsh`, `neovim`,
`tmux`.

    ~/.dotfiles/stow.sh --purge --foot --neovim --tmux --zsh --swayfx jinx

Use `--purge` if need to reinstall files as first argument.  
The theme you want as last argument `--swayfx jinx`.

I recommend you to create an alias or function (for Fish) here for easy
reinstall, e.g for Zsh:

    alias reinstall_jinx="~/.dotfiles/stow.sh --purge --foot --neovim --tmux --zsh --swayfx jinx"

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

    ~/.dotfiles/stow.sh --purge --foot --swayfx holy
    reaver

### Create your own theme

Follow the guide to create your own theme.  
https://szorfein.vercel.app/post/your-own-swayfx-theme

### Thanks lighten library using Material 3 with CSS

- https://github.com/w3teal/gmx.css or https://gmxcss.js.org/
- https://github.com/beercss/beercss or https://www.beercss.com/
