# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# Save multiline commands in history
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, Bash replaces directory names with the results of word expansion
# when performing filename completion
shopt -s direxpand

# If set, Bash attempts spelling correction on directory names during
# word completion if the directory name initially supplied does not exist.
shopt -s dirspell

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# append to the history file, don't overwrite it
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # display current time, user, host, dir and branch info (if available) at one line, and command at the next line. Something like:
    # [16:50:29] user at host in ~/dir (main %=)
    # $
    PS1='\[\033[01;36m\][\t] \[\033[1;34m\]\u\[\033[0m\] \[\033[1;37m\]at\[\033[m\] \[\033[1;36m\]\h\[\033[m\] \[\033[1;37m\]in\[\033[m\] \[\033[1;32m\]\w\[\033[m\]\[\033[00m\]$(__git_ps1 " (%s)")\n\[\033[1;37m\]$\[\033[m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm or screen set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|screen*)
    if [ -n "$STY" ] ; then
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u(${STY#[0-9]*.})@\h: \w\a\]$PS1"
    else
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    fi
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Make custom scripts available everywhere to the user
if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$PATH:$HOME/.local/bin"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi

# check if running in Windows Subsystem for Linux
if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    # fix support for running remote GUI software with VcXsrv
    # https://sourceforge.net/projects/vcxsrv/
    export DISPLAY=:0

    # fix support for running remote GUI software with XMing
    # export DISPLAY=localhost:0.0

    # change ugly green background color in folders for purple (more readable)
    export LS_COLORS="$LS_COLORS:ow=1;34;35"
fi

# enable broot - A new way to see and navigate directory trees (in terminal)
if [ -d "$HOME/.config/broot/launcher/bash/br" ] ; then
    . $HOME/.config/broot/launcher/bash/br
fi

# enable direnv - load and unload environment variables depending on the current directory
if hash direnv 2>/dev/null; then
    eval "$(direnv hook bash)"
fi

# enable fzf completion and key bindings
if [ -d "/usr/share/doc/fzf/examples/" ]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
    # . /usr/share/doc/fzf/examples/completion.bash
elif [ -f $HOME/.fzf.bash ]; then
    . $HOME/.fzf.bash
elif [ -d "$HOME/.fzf" ]; then
    . $HOME/.fzf/completion.bash
    . $HOME/.fzf/key-bindings.bash
fi

# enable java
if hash java 2>/dev/null; then
    JAVA_HOME=/usr
fi

# enable navi - an interactive cheatsheet tool for the command-line
if hash navi 2>/dev/null; then
    eval "$(navi widget bash)"
fi

# enable node version manager
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# enable pay-respects
if hash pay-respects 2>/dev/null; then
    eval "$(pay-respects bash --alias)"
fi

# enable pipenv
if hash pipenv 2>/dev/null; then
    eval "$(_PIPENV_COMPLETE=bash_source pipenv)"
fi

# enable pipx autocomplete
if hash pipx 2>/dev/null; then
    eval "$(register-python-argcomplete pipx)"
fi

# enable rbenv
if [ -d "$HOME/.rbenv/" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init - bash)"
fi

# enable starship prompt
if hash starship 2>/dev/null; then
    eval "$(starship init bash)"
fi

# enable uv - an extremely fast Python package and project manager, written in Rust
if hash uv 2>/dev/null; then
    eval "$(uv generate-shell-completion bash)"
fi

# enable uvx - uv specialized support for easily invoking and installing tools
if hash uvx 2>/dev/null; then
    eval "$(uvx --generate-shell-completion bash)"
fi

# enable zoxide - a fast cd command that learns your habits
if hash zoxide 2>/dev/null; then
    eval "$(zoxide init bash)"
fi

# Support git information
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_HIDE_IF_PWD_IGNORED=true
export GIT_PS1_SHOWUPSTREAM='auto'
