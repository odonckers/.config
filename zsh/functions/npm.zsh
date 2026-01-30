#!/usr/bin/env zsh

npm-bundle-dump() {
  NPMFILE="$XDG_CONFIG_HOME/npm/npmfile"
  mkdir -p $(dirname $NPMFILE)
  npm list --json --global --depth=0 | jq -r '.dependencies | keys[]' > $NPMFILE
}

npm-bundle-install() {
  NPMFILE="$XDG_CONFIG_HOME/npm/npmfile"
  if [ ! -f "$NPMFILE" ]; then
      echo "Error: npmfile not found at $NPMFILE"
      return 1
  fi
  if [ ! -s "$NPMFILE" ]; then
      echo "Error: npmfile is empty"
      return 1
  fi
  npm install --global $(cat "$XDG_CONFIG_HOME/npm/npmfile")
}
