#    ▒███████▒  ██████  ██░ ██  ██▀███   ▄████▄  
#    ▒ ▒ ▒ ▄▀░▒██    ▒ ▓██░ ██▒▓██ ▒ ██▒▒██▀ ▀█  
#    ░ ▒ ▄▀▒░ ░ ▓██▄   ▒██▀▀██░▓██ ░▄█ ▒▒▓█    ▄ 
#      ▄▀▒   ░  ▒   ██▒░▓█ ░██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
#    ▒███████▒▒██████▒▒░▓█▒░██▓░██▓ ▒██▒▒ ▓███▀ ░
#    ░▒▒ ▓░▒░▒▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░ ▒▓ ░▒▓░░ ░▒ ▒  ░
#    ░░▒ ▒ ░ ▒░ ░▒  ░ ░ ▒ ░▒░ ░  ░▒ ░ ▒░  ░  ▒   
#    ░ ░ ░ ░ ░░  ░  ░   ░  ░░ ░  ░░   ░ ░        
#      ░ ░          ░   ░  ░  ░   ░     ░ ░      
#    ░                                  ░        

set -o vi

# Themes are into ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each time
ZSH_THEME="spaceship"

# Plugin list in ~/.oh-my-zsh/plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/plugins
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gpg-agent
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/transfer
# MAYBE
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/starship
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pass
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copyfile
plugins=(git-prompt gpg-agent transfer)

# Disable oh-my-zsh update (before load ohmyzsh)
# https://github.com/ohmyzsh/ohmyzsh#getting-updates
zstyle ':omz:update' mode disabled

source $ZSH/oh-my-zsh.sh

# Load .aliases.zsh
[ -r $HOME/.aliases.zsh ] && source $HOME/.aliases.zsh

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items

# Completion
autoload -Uz compinit
compinit -i

#unset GREP_OPTIONS
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
  eval "$(dircolors -b)"

# man page with less
man() {
  LESS_TERMCAP_mb=$'\e[0;31m' \
    LESS_TERMCAP_md=$'\e[01;35m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;31;31m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[0;36m' \
    command man "$@"
}
