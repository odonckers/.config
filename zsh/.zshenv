#!/usr/bin/env zsh

export XDG_CONFIG_HOME="$HOME/.config" && mkdir -p $XDG_CONFIG_HOME
export XDG_DATA_HOME="$HOME/.local/share" && mkdir -p $XDG_DATA_HOME
export XDG_STATE_HOME="$HOME/.local/state" && mkdir -p $XDG_STATE_HOME
export XDG_CACHE_HOME="$HOME/.cache" && mkdir -p $XDG_CACHE_HOME
export XDG_RUNTIME_DIR="$HOME/.local/run/$UID" && mkdir -p $XDG_RUNTIME_DIR

mkdir -p "$XDG_STATE_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
export HISTFILE="$XDG_STATE_HOME/zsh/history"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export GOPATH="$XDG_DATA_HOME/go"

export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$DOTNET_CLI_HOME/tools"
export PATH="$PATH:/opt/homebrew/opt/node@24/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="$PATH:$HOME/.opencode/bin"
export PATH="$PATH:$XDG_CONFIG_HOME/scripts/bin"

(( $+commands[brew] )) && eval $(brew shellenv)

[[ -f "$XDG_DATA_HOME/cargo/env" ]] && source "$XDG_DATA_HOME/cargo/env"

[[ -f $HOME/.zshenv.local ]] && source $HOME/.zshenv.local
