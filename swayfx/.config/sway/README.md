# SwayFX

## Dependencies

The whole (or many) stack has changed because wayland instead of X.
[migration_guide](https://github.com/swaywm/sway/wiki/i3-Migration-Guide)

- swayfx - wm and compositor
- wezterm - replace xst (tested foot (very fast and good also)) and kitty (not
  very interested but it's an option)
- imv - images viewer, replace feh
- eww - widgets (instead of the awesomewm API)
- swaybg
- wl-clipboard
- jq
- grim (screenshot), replace scrot
- playerctl, mpd-mpris or mpdris2, mpv-mpris, mpc (needed to manage mpd
  playlists)
- ruby
- light, inotify-tools
- Nemo (optional)
- Neovim (optional) - replace doomemacs and vim
- Pinta (optional), replace Gimp.
- Dunst - Notification.
- imagemagick - Convert cover album

### Archlinux

    sudo pacman -Syy papirus-icon-theme \
    inotify-tools imv jq mpd mpc wl-clipboard curl stow \
    bc imagemagick rubygems grim swaybg wmenu \
    playerctl mpd-mpris mpv-mpris wezterm rust \
    git meson scdoc wayland-protocols cairo gdk-pixbuf2 \
    libevdev libinput json-c libgudev wayland libxcb \
    libxkbcommon pango pcre2 wlroots0.19 seatd \
    libdrm libglvnd pixman glslang meson ninja \
    cargo libdbusmenu-gtk3 gtk3 gtk-layer-shell \
    iwd thunar dunst

From AUR:

    scenefx swayfx eww light

Before installing `eww` from AUR, you need to import gpg key:

    curl -sS https://github.com/elkowar.gpg | gpg --import
    curl -sS https://github.com/web-flow.gpg | gpg --import

Required step as root

    usermod -aG seat username
    systemctl enable seatd
    systemctl start seatd

### Voidlinux

Install your
[graphic driver](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html)
first. e.g for intel:

    sudo xbps-install -S linux-firmware-intel mesa-dri intel-video-accel

Swayfx dependencies

    sudo xbps-install -S swayfx imv light jq wl-clipboard \
    papirus-icon-theme inotify-tools mpd mpc wezterm curl \
    stow playerctl mpv-mpris mpDris2 eww ruby swaybg grim \
    wmenu iwd Thunar seatd turnstile dunst

Required step as root

    usermod -aG _seatd username
    ln -s /etc/sv/seatd /var/service
    ln -s /etc/sv/turnstiled /var/service

### Gentoo

You will need to activate [GURU](https://github.com/gentoo/guru)

    sudo emerge -av light net-misc/curl stow
    papirus-icon-theme xfce-base/thunar \
    inotify-tools swaybg imv app-misc/jq \
    app-misc/jq media-sound/mpd media-sound/mpc \
    dev-lang/ruby playerctl wl-clipboard wezterm \
    gui-apps/grim gui-apps/wmenu net-wireless/iwd \
    gui-apps/eww gui-wm/swayfx mpv-mpris mpd-mpris \
    acct-group/seat seatd

> [!WARNING] Wezterm on musl don't compile
> [error-on-ld](https://bugs.gentoo.org/937717), you may use foot instead.

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

See on gentoo [wiki](https://wiki.gentoo.org/wiki/Sway#Starting_Sway_manually)

### From Ruby

After the installation of the dependencies, for all distros, Install `i3ipc` locally:

    gem install --user-install i3ipc

## Cloning this repo

Copy this repository:

    git clone https://github.com/szorfein/dotfiles ~/.dotfiles

If you add my dotfiles in another place, edit your shell (see below)

## Configuration

### Shell

You have to add 5 lines in your shell `.bash_profile`, `.zprofile`, etc

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

And follow configurations for keymap on the
[sway-wiki](https://github.com/swaywm/sway/wiki#locale-specific-configuration-tricks)

### Run test-dpi.sh

Configs need 2 files in `~/.eww_scale` and `~/.config/eww/_scale.scss` generated
with the script.

    ~/.dotfiles/swayfx/bin/test-dpi.sh 1366 768 11.6
    dp scale factor 0.8443388199535182

The script need 3 paramaters to calculate your DPI:
- `$1` horizontal screen, 
- `$2` vertical
- `$3` is the diagonale

### Interact with iwd

User need to be added in `network` or `wheel` group.

    usermod -aG network username

## Installation

Before using stow, make sure to backup all your personal files and move them in
a backup directory.

Using my script `stow.sh`, you'll need to install at least: `swayfx` and a
`swayfx-themes` (last is `jinx`).

    ~/.dotfiles/stow.sh --swayfx jinx

If you want a more complete command, you can also add `wezterm`, `zsh`,
`neovim`, `tmux`.

    ~/.dotfiles/stow.sh --purge --wezterm --neovim --tmux --zsh --swayfx jinx

Use `--purge` if need to reinstall files as first argument.

I recommand you to create an alias or function (for Fish) here for easy reinstall, e.g for Zsh: 

    alias reinstall_jinx="~/.dotfiles/stow.sh --purge --wezterm --swayfx jinx --neovim --tmux --zsh"

## Download other dependencies

After installing dotfiles with `stow.sh`, last step is to downloads all the
required files (wallpapers, fonts, gtk-themes, icons, etc) in two commands, thanks ([reaver](https://geeksrepos.com/szorfein/reaver)):

    gem install --user-install reaver
    reaver

## Updates

Update the repo using `git pull`

    cd .dotfiles && git pull

Reinstall files with `stow.sh --purge` to reinstall new dotfiles.

    ~/.dotfiles/stow.sh --purge --wezterm --swayfx holy
    reaver

### Create your own theme

Follow the guide to create your own theme.  
https://szorfein.vercel.app/post/your-own-swayfx-theme

### Thanks lighten libs using m3 with css

- https://github.com/w3teal/gmx.css or https://gmxcss.js.org/
- https://github.com/beercss/beercss or https://www.beercss.com/
