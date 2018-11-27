# Basics.
umask 027

export KEYTIMEOUT=1
export EDITOR=nvim
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH=~/dev/go
export PATH="$HOME/bin:$GOPATH/bin:$PATH"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"

# macOS specifics.
if [[ `uname` == 'Darwin' ]]; then
    export COPYFILE_DISABLE=1
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/binutils/bin:/usr/local/bin:$PATH"
    export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
fi

# antibody plugins.
if ! which antibody >/dev/null 2>&1; then
    curl -sL git.io/antibody | sh -s
fi

DISABLE_AUTO_UPDATE=true
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

autoload -Uz compinit
compinit -i

if [ ! -f ~/.zsh_plugins.sh ]; then
    antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
fi

source ~/.zsh_plugins.sh

# Aliases.
alias ls='ls --color=auto'  # Fixes coreutils ls after zsh plugins run.
alias dockerclean='docker kill $(docker ps -q) ; docker rm $(docker ps -a -q) ; docker rmi -f $(docker images -q -f dangling=true) ; docker rmi -f $(docker images -q)'

# Wrap up.
[ -f ~/.customrc ] && source ~/.customrc

gpg-connect-agent updatestartuptty /bye >/dev/null

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi
