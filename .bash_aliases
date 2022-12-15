# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# some ls aliases
alias ls='ls --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alhF'
alias lsd='ls -Alh --color=always --sort=time --reverse ~/Downloads/ | tail'
alias lsrecent='ls -lh --sort=time -r'

# program default options / shortcuts
alias df='df -h'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias hgrep='history | grep'
alias ipy='ipython3'
alias py='python3'
alias txz='tar xvzf'
alias ssh='ssh -X'

# enable color support of bat
alias bat='batcat --theme=TwoDark'

# allows fdfind to be called as fd
# https://github.com/sharkdp/fd
alias fd=fdfind

# exa default options
alias exa='exa --icons --group-directories-first'

# rclone alias to always show downloading files
alias rclone='rclone -v'

# Telegram send end of command alias
# usage: sleep 10; tg
alias tg='telegram-send "$([ $? = 0 ] && echo "" || echo "error: ") $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*tg$//'\'')"'

# to use tg in shell scripts, add the following lines to the script
## expand aliases to allow use of ‘tg’ alias
# set -o history -o histexpand
# shopt -s expand_aliases
