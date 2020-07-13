# Basics.
umask 027

fish_vi_key_bindings

# Exports.
set -xg fish_greeting

set -xg EDITOR nvim
set -xg LANG en_US.UTF-8
set -xg LANGUAGE en_US.UTF-8
set -xg LC_ALL en_US.UTF-8

set -xg GOPATH ~/dev/go
set -xg PYTHONPATH "$PYTHONPATH:/opt/binaryninja/python"
set -xg PATH "$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH:$GOPATH/bin:$HOME/.cargo/bin:/usr/local/opt/ruby/bin:$HOME/sec/ios/tools/build/bin:$PATH"

if test (uname) = Darwin
    set -xg COPYFILE_DISABLE 1

    set -xg PATH "/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/binutils/bin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gnu-indent/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/python@3.8/libexec/bin:$PATH"
    set -xg PYTHONPATH "$PYTHONPATH:/Applications/Binary Ninja.app/Contents/Resources/python"
end

# Aliases.
alias l='ls -al'
alias lR='ls -alR'
alias ...='cd ../../'
alias ....='cd ../../../'

alias dockerclean='docker kill (docker ps -q) ; docker rm (docker ps -a -q) ; docker rmi -f (docker images -q -f dangling=true) ; docker rmi -f (docker images -q)'

alias gss='git status -s'
alias gco='git checkout'
alias gp='git push'
alias gc='git commit -v'
alias glgg='git log --graph'

if test (uname) = Darwin
    alias clipcopy='pbcopy'
else
    alias clipcopy='xclip'
end

# GPG / SSH.
if test (uname) = Darwin
    set -xg SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh
else
    set -xg SSH_AUTH_SOCK "/run/user/$UID/gnupg/S.gpg-agent.ssh"
end

if ! test (gpgconf --list-dirs | grep agent-socket | cut -d : -f 2)
    gpg-agent --daemon
end

# TODO: current k8s cluster in RPROMPT.

# System specifics.
if test -e ~/.customrc
    source ~/.customrc
end

# Plugins.
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

    fish -c fisher
end
