# SwayFX

## Dependencies
The whole (or many) stack has changed because wayland instead X.
[migration_guide](https://github.com/swaywm/sway/wiki/i3-Migration-Guide)

- swayfx - wm and compositor
- wezterm - replace xst (tested foot (very fast and good also)) and kitty (not very interested by a console written in Python, Go, C and++)
- imv - images viewer, replace feh
- eww - widgets (instead of the awesomewm API)
- swaybg
- gem install --user-install i3ipc
- wl-clipboard
- jq
- grim (screenshot), replace scrot
- playerctl, mpd-mpris or mpdris2, mpv-mpris

For emacs, you should use emacs-wayland intead of emacs-nativecomp

## Configure keymap

Modify the default xkb-config.env

    cp xkb-config.env xkb-config

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
