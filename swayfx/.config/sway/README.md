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
- playerctl, mpd-mpris or mpdris2, mpv-mpris
- ruby (ruby-gem)
- light, inotify-tools
- Neovim (optional) - replace doomemacs and vim
- Pinta, replace Gimp.

## From Ruby

    gem install --user-install i3ipc

You also need to add ruby in your `$PATH` via .zprofile, .zshenv, etc...

    export GEM_HOME="$(gem env user_gemhome)"
    export PATH="$PATH:$GEM_HOME/bin"

## Configure keymap

Modify the default xkb.example

    cp xkb.example keyboard

For a french keyboard for example, you need to change the default 'en'

```sh
# https://github.com/swaywm/sway/wiki#keyboard-layout
input type:keyboard {
  xkb_layout fr
}

# And customize fews keys
# See https://github.com/swaywm/sway/wiki#locale-specific-configuration-tricks
bindsym $mod+ampersand workspace number 1
...etc
```

## Run test-dpi.sh
Configs need 2 files in `~/.eww_scale` and `~/.config/eww/_scale.scss` generated with the script.

    ~/.dotfiles/swayfx/bin/test-dpi.sh 1366 768 11.6
    dp scale factor 0.8443388199535182

To load .eww_scale, you need to add it in your shell e.g .zprofile

    source ~/.eww_scale

## Interact with IWD
User need to be added in `network` or `wheel` group.

    usermod -aG network username

