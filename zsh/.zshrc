#!/usr/bin/env zsh

if [[ -d $HOME/.oh-my-zsh ]]; then
  export ZSH=$HOME/.oh-my-zsh
  ZSH_THEME=robbyrussell
  source $ZSH/oh-my-zsh.sh
fi

typeset -aU fpath
fpath=(~/.completions $fpath)
[[ -d $HOME/.docker ]] && fpath=($HOME/.docker/completions $fpath)

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
  compinit
else
  compinit -C
fi

(( $+commands[nvim] )) && alias vim=nvim
(( $+commands[eza] )) && alias ls=eza
(( $+commands[lazygit] )) && alias lg=lazygit
(( $+commands[assume] )) && alias assume=". assume"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

if (( $+commands[ng] )); then
  alias ng-clean="ng generate @angular/core:cleanup-unused-imports"
  source <(ng completion script)
fi

[[ -s $NVM_DIR/nvm.sh ]] && . $NVM_DIR/nvm.sh
[[ -s $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
[[ -s $HOME/.cargo/env ]] && . $HOME/.cargo/env

alias l="ls -l --git"
alias ll="l -ah"
alias v=vim

[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

set -o vi
