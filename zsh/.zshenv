# PATH
PATH="$HOME/bin:$PATH"

if hash ruby 2>/dev/null ; then
  PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
fi

if hash yarn 2>/dev/null ; then
  PATH="$PATH:${HOME}/.yarn/bin"
fi

[ -d $HOME/.emacs.d/bin ] && PATH="$HOME/.emacs.d/bin:$PATH"

export PATH

export TERMINAL=xst

# GPG
export GPG_TTY=$(tty)
export GPG_AGENT_INFO=""

# Editor
export VISUAL=vim
export EDITOR=$VISUAL
export SUDO_EDITOR=$VISUAL

# nnn
[ -f ~/.config/nnn/plugins/nuke ] && export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
[ -f ~/.config/nnn/plugins/sxiv ] && export NNN_PLUG="s:sxiv"

# Proxy
#export http_proxy="http://127.0.0.1:45411"
#export https_proxy=${http_proxy}
#export ftp_proxy=${http_proxy}
#export rsync_proxy=${http_proxy}
#export HTTP_PROXY=${http_proxy}
#export HTTPS_PROXY=${http_proxy}
#export no_proxy="localhost,127.0.0.1,localaddress,localdomain.com"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Hacking Tools
export HYDRA_PROXY_HTTP="$HTTP_PROXY"

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

# If mpd port is different than default 6600
# export MPD_PORT="6600"
