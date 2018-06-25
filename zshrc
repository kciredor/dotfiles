#
# ZSH INIT.
#

umask 027

export EDITOR=vim
export GOPATH=~/dev/go
export KEYTIMEOUT=1
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias cl='clear'

# macOS specifics.
if [[ `uname` == 'Darwin' ]]; then
    export COPYFILE_DISABLE=1
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
    export TERM=xterm-256color
fi

export PATH="$HOME/bin:$GOPATH/bin:$PATH"

# Antigen plugins.
[ -f ~/.antigen.zsh ] || (echo "Fetching antigen.zsh..." && curl -o ~/.antigen.zsh -s https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh)

source ~/.antigen.zsh

antigen bundle robbyrussell/oh-my-zsh lib/
antigen theme kciredor/dotfiles themes/kciredor
# antigen theme agkozak/agkozak-zsh-theme
# antigen theme yous/lime

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen bundle vi-mode
antigen bundle history
antigen bundle autojump
antigen bundle tmux
antigen bundle thefuck

antigen bundle git
antigen bundle docker
antigen bundle aws
antigen bundle golang
antigen bundle python
antigen bundle node
antigen bundle gem

antigen bundle nmap

if [[ `uname` == 'Darwin' ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle osx

    antigen bundle ssh-agent
fi

if [[ -f /etc/arch-release ]]; then
    antigen bundle archlinux

    antigen bundle gpg-agent
    unset SSH_AGENT_PID
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
    gpg-connect-agent updatestartuptty /bye >/dev/null
fi

antigen apply

# System specifics.
[ -f ~/.customrc ] && source ~/.customrc

# Ruby last.
export PATH="$PATH:$HOME/.rvm/bin"
source "$HOME/.rvm/scripts/rvm"

# Start X.
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi
