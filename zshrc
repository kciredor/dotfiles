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

export PATH="$HOME/dev/go/bin:$PATH"

# Antigen plugins.
[ -f ~/.antigen.zsh ] || (echo "Fetching antigen.zsh..." && curl -o ~/.antigen.zsh -s https://raw.githubusercontent.com/zsh-users/antigen/develop/bin/antigen.zsh)

source ~/.antigen.zsh

antigen bundle robbyrussell/oh-my-zsh lib/
antigen theme kciredor/dotfiles themes/kciredor

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen bundle ssh-agent
antigen bundle gpg-agent
antigen bundle tmux
antigen bundle tmuxinator
antigen bundle history
antigen bundle vi-mode
antigen bundle autojump

antigen bundle git
antigen bundle docker
antigen bundle aws
antigen bundle golang
antigen bundle pip
antigen bundle python
antigen bundle virtualenv

antigen bundle nmap

if [[ `uname` == 'Darwin' ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle gem
    antigen bundle osx
fi

if [[ -f /etc/arch-release ]]; then
    antigen bundle archlinux
fi

antigen apply

# Device specifics.
[ -f ~/.custom_alias ] && source ~/.custom_alias
