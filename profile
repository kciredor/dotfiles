# config

export EDITOR='vim'
complete -d cd
set -o vi


# mac fixes

COPYFILE_DISABLE=true
CLICOLOR=1
LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-color


# autojump

if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
    . /opt/local/etc/profile.d/autojump.sh
fi


# git

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
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

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/
export PATH=/opt/local/libexec/gnubin/:$PATH
export PATH=/Library/Python/2.6/site-packages/django/bin:$PATH
export PATH=/Developer/usr/bin:/Developer/usr/sbin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export PATH=/Users/roderick/Apps/android-sdk-macosx/tools:$PATH
export PATH=/Users/roderick/Apps/android-sdk-macosx/platform-tools:$PATH


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
