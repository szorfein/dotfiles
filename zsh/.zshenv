# PATH
MY_PATH="$HOME/bin"

# https://wiki.archlinux.org/title/Ruby#Setup
if hash ruby 2>/dev/null ; then
  export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
  MY_PATH="$MY_PATH:$GEM_HOME/bin"
fi

# Javascript - Npm - Yarn
# 'npm -g install packagename' should install here
# 'npm -g uninstall packagename'
# 'npm -g list'
# 'npm update -g'
MY_PATH="$MY_PATH:$HOME/.npm/bin"
export npm_config_prefix="$HOME/.npm"

# Doom Emacs
# https://github.com/doomemacs/doomemacs#install
if [ -d $HOME/.config/emacs/bin ] ; then
   MY_PATH="$MY_PATH:$HOME/.config/emacs/bin"
fi

# if Turso
[ -d "$HOME/.turso" ] && MY_PATH="$MY_PATH:$HOME/.turso"

export PATH="$PATH:$MY_PATH"

# XDG
export XDG_CONFIG_HOME="$HOME"/.config

# Locale
export LANG=en_US.UTF-8

# History
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# Terminal
export TERMINAL=footclient

# Editor
export EDITOR=nvim
export SUDO_EDITOR=nvim
export VISUAL=nvim

[ -f "$HOME/.eww_scale" ] && source "$HOME/.eww_scale"

# GPG (using plugin from ohmyzsh instead)
# export GPG_TTY=$(tty)
# export GPG_AGENT_INFO=""

# MPD Dir
export MPD_MUSIC_DIR="$HOME/musics"
# If mpd port is different than default 6600
# export MPD_PORT="6600"

# Path to your oh-my-zsh installation.
export ZSH="$HOME"/.oh-my-zsh

# Ansible
export ANSIBLE_CONFIG="$HOME"/.config/ansible/ansible.cfg

# Proxy
#export http_proxy="http://127.0.0.1:45411"
#export https_proxy=${http_proxy}
#export ftp_proxy=${http_proxy}
#export rsync_proxy=${http_proxy}
#export HTTP_PROXY=${http_proxy}
#export HTTPS_PROXY=${http_proxy}
#export no_proxy="localhost,127.0.0.1,localaddress,localdomain.com"

# Hacking Tools
# export HYDRA_PROXY_HTTP="$HTTP_PROXY"

# export RB_USER_INSTALL='true'
# export RAILSLAB_U=""
# export SHAKEN_U=""
# export RAILSLAB_C="$HOME/.certs/mongo-client.pem"
# export SHAKEN_C="$HOME/.certs/mongo-shaken-client.pem"
# export MONGO_CA="$HOME/.certs/mongo-ca.pem"
# decrypt secret with rails
# export RAILS_MASTER_KEY=$(cat $HOME/labs/szorfein/Erebe/config/secrets.yml.key)
# export AUTH0_CLIENT=""
# export AUTH0_SEC=""
# decrypt session with rails
#export SECRET_KEY_BASE=$(rake secret)

# If Bspwm
# export PANEL_FIFO="/tmp/panel-fifo"

# If JAVA
# export _JAVA_AWT_WM_NONREPARENTING=1
# export _JAVA_OPTIONS=-Djava.io.tmpdir=/var/tmp
# export JAVA_HOME=/opt/oracle-jdk-bin-1.8.0.112

# If use ionic
# export PATH=$HOME/node_modules/cordova/bin:$HOME/bin:/usr/lib64/node_modules:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME:$PATH

# If jekyll, mkdir -p ~/.gems/bin
# export GEM_PATH=/home/izsha/.gems:/usr/lib64/ruby/gems/2.3.0/gems/

