#!/usr/bin/env zsh

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

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

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
  alias mx="mise exec --"
fi

(( $+commands[assume] )) && alias assume=". assume"
(( $+commands[eza] )) && alias ls=eza
(( $+commands[lazygit] )) && alias g=lazygit
(( $+commands[ng] )) && source <(ng completion script)
(( $+commands[nvim] )) && alias vim=nvim
if (( $+commands[tmux] )); then
  alias t=tmux
  alias ta="tmux attach"
  alias tks="tmux kill-server"
fi
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

alias l="ls -l --git"
alias ll="l -ah"
alias v=vim

[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

set -o vi
