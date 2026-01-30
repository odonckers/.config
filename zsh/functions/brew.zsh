#!/usr/bin/env zsh

brew-backup() {
  brew bundle dump --global --force
}

brew-install() {
  : "${1? brew-install [options] formula|cask [...]}"
  brew install $1
  brew-backup
}

brew-uninstall() {
  : "${1? brew-uninstall [options] installed_formula|installed_cask [...]}"
  brew uninstall $1
  brew-backup
}

brew-update() {
  brew update
  brew bundle upgrade --global
}
