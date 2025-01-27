# SwayFX

## Dependencies
The whole (or many) stack has changed because wayland instead X.
[migration_guide](https://github.com/swaywm/sway/wiki/i3-Migration-Guide)

- swayfx - wm and compositor
- wezterm - replace xst (tested foot (very fast and good also)) and kitty (not very interested by a console written in Python and Go but it's an option)
- imv - images viewer, replace feh
- eww - widgets (instead of the awesomewm API)
- swaybg
- wl-clipboard
- jq
- grim (screenshot), replace scrot
- playerctl, mpd-mpris or mpdris2, mpv-mpris, mpc (needed to manage mpd playlists)
- ruby
- light, inotify-tools
- Neovim (optional) - replace doomemacs and vim
- Pinta (optional), replace Gimp.

### Archlinux

    sudo pacman -Syy papirus-icon-theme \
    inotify-tools imv jq mpd mpc wl-clipboard curl stow \
    bc imagemagick rubygems grim swaybg wmenu \
    playerctl mpd-mpris mpv-mpris wezterm \ 
    git meson scdoc wayland-protocols cairo gdk-pixbuf2 \
    libevdev libinput json-c libgudev wayland libxcb \
	libxkbcommon pango pcre2 wlroots0.17 \
    libdrm libglvnd pixman glslang meson ninja \
    cargo libdbusmenu-gtk3 gtk3 gtk-layer-shell \
    iwd

From AUR:

    scenefx swayfx eww light

### Voidlinux

    sudo xbps-install -S swayfx imv light jq wl-clipboard \
    papirus-icon-theme inotify-tools mpd mpc wezterm curl \
    stow playerctl mpv-mpris mpDris2 eww ruby swaybg grim \
    wmenu iwd

### Gentoo
You will need to activate [GURU](https://github.com/gentoo/guru)

    sudo emerge -av light curl stow papirus-icon-theme \
    inotify-tools swaybg imv \
    app-misc/jq media-sound/mpd media-sound/mpc \
    dev-lang/ruby playerctl wl-clipboard wezterm \
    gui-apps/grim gui-apps/wmenu net-wireless/iwd \
    gui-apps/eww gui-wm/swayfx mpv-mpris mpd-mpris

### From Ruby
Install `i3ipc` locally

    gem install --user-install i3ipc

## Configuration

### Shell
You have to add 4 lines in your shell `.bash_profile`, `.zprofile`, etc

```sh
# Load eww_scale
[ -f "$HOME/.eww_scale" ] && source "$HOME/.eww_scale"

# Ruby Path
export GEM_HOME="$(gem env user_gemhome)"
export PATH="$PATH:$GEM_HOME/bin"

# Mpd music dir, you also have to configure mpd...
export MPD_MUSIC_DIR="$HOME/where-musics-are"
```
And reload your shell after that.

### Keyboard
Modify the default xkb.example in this directory.

    cp xkb.example keyboard

For a french keyboard for example, you need to change the default `xkb_layout us'

```sh
# https://github.com/swaywm/sway/wiki#keyboard-layout
input type:keyboard {
  xkb_layout fr
}
```

And follow configurations for keymap on the [sway-wiki](https://github.com/swaywm/sway/wiki#locale-specific-configuration-tricks)

### Run test-dpi.sh
Configs need 2 files in `~/.eww_scale` and `~/.config/eww/_scale.scss` generated with the script.

    ~/.dotfiles/swayfx/bin/test-dpi.sh 1366 768 11.6
    dp scale factor 0.8443388199535182

### Interact with iwd
User need to be added in `network` or `wheel` group.

    usermod -aG network username

## Installation
Copy this repository:

    git clone https://github.com/szorfein/dotfiles ~/.dotfiles

Using `stow`, you need to install `swayfx` and a `swayfx-themes`

    cd ~/.dotfiles
    stow swayfx -t ~
    stow -d swayfx-themes holy -t ~
