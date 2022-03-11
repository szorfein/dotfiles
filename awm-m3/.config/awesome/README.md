# Awesome M3

Minimal implementation of the [material guide](https://m3.material.io/) for AwesomeWM.

+ Use [Design-Token](https://m3.material.io/foundations/design-tokens/overview)
+ (will|maybe) Support dark and white theme.
+ Colors are designed to meet accessibility standards for color contrast.
+ Script comptatible with `/bin/dash`.
+ Lighten WM, consume around 145Mb of memory.
+ Can works with [Musl](https://musl.libc.org/about.html)

## Dependencies

| Roles | Requirements |
|---|---|
| WM | Last release of [Awesome](https://github.com/awesomeWM/awesome) |
| Font | Any [Nerd font](https://github.com/ryanoasis/nerd-fonts) |
| Icon Font | [Material Icon Desktop](https://github.com/Templarian/MaterialDesign-Font) |
| Compositor | Picom |
| Brightness | [Light](https://github.com/haikarainen/light) |
| Music Player | [MPD](https://www.musicpd.org/) controlled by [mpc](https://www.musicpd.org/clients/mpc/) |
| Sound | Work with [ALSA](https://www.alsa-project.org/main/index.php/Main_Page) and [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) |
| ACPI | [acpid 2](https://sourceforge.net/projects/acpid2/) |
| Remote Watch | [Curl](https://curl.haxx.se) |
| JSON Parser | [jq](https://github.com/stedolan/jq) |

## Install with Stow

    stow awm-m3

## Update

    git pull
    stow -R awm-m3