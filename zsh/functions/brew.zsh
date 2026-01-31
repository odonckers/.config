#!/usr/bin/env zsh

brew-backup() {
  brew bundle dump --global --force
}

brew-restore() {
  brew bundle install --global
}

brew-install() {
  if [ -z "$1" ]; then
      echo "Usage: brew-install [options] <formula|cask> [...]"
      echo ""
      return 1
  fi

  brew install $1
  brew-backup
}

brew-uninstall() {
  if [ -z "$1" ]; then
      echo "Usage: brew-uninstall [options] <installed_formula|installed_cask> [...]}"
      echo ""
      return 1
  fi

  brew uninstall $1
  brew-backup
}

brew-update() {
  brew update
  brew bundle upgrade --global
}
