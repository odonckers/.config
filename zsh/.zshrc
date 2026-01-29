#!/usr/bin/env zsh

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

if [[ -d "$XDG_DATA_HOME/oh-my-zsh" ]]; then
  export ZSH="$XDG_DATA_HOME/oh-my-zsh"
  ZSH_THEME=robbyrussell
  source $ZSH/oh-my-zsh.sh
else
  autoload -Uz compinit
  compinit -d "$ZSH_COMPDUMP"
fi

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
  alias mx="mise exec --"
fi

(( $+commands[assume] )) && alias assume=". assume"
(( $+commands[eza] )) && alias ls=eza
(( $+commands[gh] )) && alias ghas="gh auth switch"
if (( $+commands[git] )); then
  alias g=git
  alias ga="git add"
  alias gb="git switch"
  alias gbc="git switch -c"
  alias gc="git commit -m"
  alias gca="git commit -am"
  alias gd="git diff"
  alias gp="git pull"
  alias gP="git push"
  alias gr="git restore"
  alias gs="git status"
fi
(( $+commands[lazygit] )) && alias lg=lazygit
(( $+commands[ng] )) && source <(ng completion script)
if (( $+commands[nvim] )); then
  alias vim=nvim
  export EDITOR="nvim"
fi
(( $+commands[opencode] )) && alias oc=opencode
if (( $+commands[tmux] )); then
  alias t=tmux
  alias ta="tmux attach"
  alias tks="tmux kill-server"
fi
(( $+commands[wget] )) && alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

alias cdc="cd $XDG_CONFIG_HOME"
alias l="ls -l --git"
alias ll="l -ah"
alias v=vim
alias vs="vim -S"

[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

set -o vi
