#!/usr/bin/env zsh

echo "💻 Installing tools..."

XDG_CONFIG_HOME="$HOME/.config"

. $XDG_CONFIG_HOME/installers/homebrew.sh
. $XDG_CONFIG_HOME/installers/uv.sh
. $XDG_CONFIG_HOME/installers/rustup.sh
. $XDG_CONFIG_HOME/installers/go.sh
. $XDG_CONFIG_HOME/installers/dotnet.sh
. $XDG_CONFIG_HOME/installers/aws-cli.sh
. $XDG_CONFIG_HOME/installers/netcoredbg.sh
. $XDG_CONFIG_HOME/installers/oh-my-zsh.sh

ln -s $XDG_CONFIG_HOME/zsh/.zshrc $HOME/.zshrc
ln -s $XDG_CONFIG_HOME/zsh/.zshenv $HOME/.zshenv

source $HOME/.zshenv
source $HOME/.zshrc

brew-restore
npm-restore
