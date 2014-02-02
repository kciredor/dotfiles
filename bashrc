# ssh keychain
if hash keychain 2>/dev/null; then
    keychain --agents ssh -q ~/.ssh/id_rsa
    . ~/.keychain/$HOSTNAME-sh
fi

# basics
export EDITOR='vim'
complete -d cd
set -o vi
export TERM=screen-256color
unset GNOME_KEYRING_CONTROL

# mac fixes: todo: detect Mac env
if false; then
    COPYFILE_DISABLE=true
    CLICOLOR=1
    LSCOLORS=gxfxcxdxbxegedabagacad
    export TERM=xterm-256color
fi

# autojump
[[ -s /usr/share/autojump/autojump.sh ]] && . /usr/share/autojump/autojump.sh
[[ -s /usr/local/etc/autojump.sh ]] && . /usr/local/etc/autojump.sh

# git
if [ -f /etc/bash_completion.d/git ]; then
    . /etc/bash_completion.d/git
fi
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
    . /usr/local/etc/bash_completion.d/git-prompt.sh
fi

function parse_git_dirty {
  git diff --quiet HEAD &>/dev/null
  [[ $? == 1 ]] && echo " *"
}
function parse_git_branch {
  local branch=$(__git_ps1 "%s")
  [[ $branch ]] && echo "[$branch$(parse_git_dirty)]"
}

export PS1='\[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

alias git='hub'
alias g='git'
alias gs='git status'
alias gc='git commit'
alias gca='git commit -a'
alias ga='git add'
alias gco='git checkout '
alias gb='git branch'
alias gm='git merge'
alias gd="git diff"

complete -o default -o nospace -F _git_branch gb
complete -o default -o nospace -F _git_checkout gco

# exports
export MSF_DATABASE_CONFIG=~/.msf4/config/database.yml

# path-exports: home
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/Developer/usr/bin:/Developer/usr/sbin:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export PATH=/opt/local/share/java/android-sdk-macosx/tools:$PATH
export PATH=/opt/local/share/java/android-sdk-macosx/platform-tools:$PATH
export PATH=/usr/local/cuda/bin:$PATH
export PATH=/Applications/Less.app/Contents/Resources/engines/bin:$PATH

# path-exports: office
export PATH=/home/kciredor/src/connect/v/bin:$PATH

# aliases
alias ls='ls --color=auto -Fh --group-directories-first'
alias ll='ls -alh'
alias l='ls'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

..() { cd "../$@"; }
..2() { cd "../../$@"; }
..3() { cd "../../../$@"; }
..4() { cd "../../../../$@"; }
..5() { cd "../../../../../$@"; }

# custom aliases
if [ -f ~/.custom_alias ]; then
    . ~/.custom_alias
fi
