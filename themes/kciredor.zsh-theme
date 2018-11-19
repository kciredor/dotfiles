#!/usr/bin/env zsh

KUBE_PS1_SYMBOL_ENABLE=false

PROMPT='%{$fg[cyan]%}[%{$fg[yellow]%} %n@%m %{$fg[cyan]%}] [%{$fg[white]%}%~%{$fg[cyan]%}] >%{$reset_color%} '
RPROMPT='%{$fg[cyan]%}[%{$fg[white]%}$(git_prompt_info)%{$fg[cyan]%}]%{$reset_color%} $(kube_ps1)'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔"
