# Basics.
umask 027

export KEYTIMEOUT=1
export EDITOR=nvim
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH=~/dev/go
export PATH="$HOME/bin:$GOPATH/bin:$HOME/.cargo/bin:/usr/local/opt/ruby/bin:$HOME/sec/ios/tools/build/bin:$PATH"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"

# macOS specifics.
if [[ `uname` == 'Darwin' ]]; then
    export COPYFILE_DISABLE=1
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/binutils/bin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gnu-indent/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/sbin:/usr/local/bin:$PATH"
    export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

    # Coreutils via homebrew gets PATH precedence, but 'df' is broken on Catalina.
    alias df='/bin/df'

    alias locate='mdfind -name'
    alias mux='/usr/local/lib/ruby/gems/2.6.0/bin/tmuxinator'
    alias lldb='PATH=~/sec/re/tools/venv/bin /usr/bin/lldb'
    alias gdb='PATH=~/sec/re/tools/venv/bin /usr/local/bin/gdb -q'
    alias voltron='~/sec/re/tools/venv/bin/voltron'
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
alias ls='ls --color=auto'  # Fixes coreutils ls after sourcing zsh plugins.
alias dockerclean='docker kill $(docker ps -q) ; docker rm $(docker ps -a -q) ; docker rmi -f $(docker images -q -f dangling=true) ; docker rmi -f $(docker images -q)'

# Wrap up.
[ -f ~/.customrc ] && source ~/.customrc

gpg-connect-agent /bye >/dev/null

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi
