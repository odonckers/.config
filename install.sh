#!/usr/bin/env bash

echo "💻 Installing tools..."

XDG_CONFIG_HOME="$HOME/.config"

. $XDG_CONFIG_HOME/installers/homebrew.sh
. $XDG_CONFIG_HOME/installers/uv.sh
. $XDG_CONFIG_HOME/installers/rustup.sh
. $XDG_CONFIG_HOME/installers/go.sh
. $XDG_CONFIG_HOME/installers/dotnet.sh
. $XDG_CONFIG_HOME/installers/aspire.sh
. $XDG_CONFIG_HOME/installers/aws-cli.sh
. $XDG_CONFIG_HOME/installers/netcoredbg.sh
. $XDG_CONFIG_HOME/installers/oh-my-zsh.sh

echo 'source $HOME/.config/zsh/zshrc' >> $HOME/.zshrc
echo 'source $HOME/.config/zsh/zshenv' >> $HOME/.zshenv

source $HOME/.zshenv
source $HOME/.zshrc

brew-restore
npm-restore

sudo sh -c 'echo /opt/homebrew/bin/zsh >> /etc/shells'
chsh -s /opt/homebrew/bin/zsh

gitleaks detect --source $XDG_CONFIG_HOME
