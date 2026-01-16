#!/usr/bin/env zsh

export TERM="xterm-256color"
export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"

export PATH="$PATH:/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="$PATH:$HOME/.opencode/bin"
export PATH="$PATH:$HOME/.dotnet/tools"

export DOTNET_ROOT="/opt/homebrew/opt/dotnet@6/libexec"

. "$HOME/.cargo/env"

[[ -f $HOME/.zshenv.local ]] && source $HOME/.zshenv.local
