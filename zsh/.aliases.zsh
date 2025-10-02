alias feh='feh -. -B black -g 628x580'
alias sxiv='sxiv -s h -g 628x580'
alias mpv='mpv --geometry="50%x50%" --auto-window-resize=no'
alias sqlmap="sqlmap --check-tor --random-agent"
alias vifm=vifmrun

if command -v nvim >/dev/null ; then
    alias vim=nvim
fi

# make xclip work with voidlinux
alias xclip='xclip -sel clip'

alias streload='xrdb merge ~/.Xresources && kill -s USR1 $(pidof xst)'

# https://elijahmanor.com/blog/fd-fzf-tmux-nvim
alias v='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
