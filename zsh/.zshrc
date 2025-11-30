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
plugins=(git-prompt gpg-agent zsh-autosuggestions starship zsh-syntax-highlighting keychain zsh-history-substring-search)

# Disable oh-my-zsh update (before load ohmyzsh)
# https://github.com/ohmyzsh/ohmyzsh#getting-updates
zstyle ':omz:update' mode disabled

zstyle ':omz:plugins:keychain' agents gpg

# If need to configure keychain identities
[ -f ~/.zsh/keychain.zsh ] && source ~/.zsh/keychain.zsh

source "$ZSH/oh-my-zsh.sh"

[ -f ~/.zprofile ] && source ~/.zprofile
[ -f ~/.zshenv ] && source ~/.zshenv

# --------
# Options
# --------

setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED	   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

# -----------
# History
# -----------

HISTSIZE=666
SAVEHIST=666
HISTFILE=~/.history
HISTDUP=erase
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt hist_save_no_dups

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
# Bindkeys
# --------------

#source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# --------------
# OTHER
# --------------

test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
  eval "$(dircolors -b)"
