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

# Plugin list in ~/.oh-my-zsh/plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/plugins
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gpg-agent
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/transfer
# https://github.com/zsh-users/zsh-autosuggestions/tree/master
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/starship
# https://github.com/zsh-users/zsh-syntax-highlighting
# MAYBE
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pass
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copyfile
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/keychain
plugins=(git-prompt gpg-agent transfer zsh-autosuggestions starship zsh-syntax-highlighting keychain)

# Disable oh-my-zsh update (before load ohmyzsh)
# https://github.com/ohmyzsh/ohmyzsh#getting-updates
zstyle ':omz:update' mode disabled

zstyle ':omz:plugins:keychain' agents gpg

source "$ZSH/oh-my-zsh.sh"

# History
HISTSIZE=666
SAVEHIST=666
HISTFILE=~/.history

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items

# Completion
autoload -Uz compinit
compinit -i

# --------------
# FUNCTIONS
# --------------

[ -f ~/.zsh/functions.zsh ] && source ~/.zsh/functions.zsh

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

# --------------
# ALIAS
# --------------

[ -f "$HOME/.aliases.zsh" ] && source "$HOME/.aliases.zsh"
[ -f "$HOME/.zsh/aliases.zsh" ] && source "$HOME/.zsh/aliases.zsh"

# --------------
# OTHER
# --------------

test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
  eval "$(dircolors -b)"
