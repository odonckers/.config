#!/usr/bin/env zsh

ide() {
  # Check if a session name/directory was provided
  if [ -z "$1" ]; then
      echo "Usage: ide <directory_name>"
      exit 1
  fi

  SESSION_NAME=$1

  # Use zoxide to find the path (query the database)
  TARGET_DIR=$(zoxide query $SESSION_NAME)

  if [ -z "$TARGET_DIR" ]; then
      echo "Error: Directory '$SESSION_NAME' not found in zoxide."
      exit 1
  fi

  # Create a new detached session and name the first window 'vim'
  tmux new-session -d -s "$SESSION_NAME" -n 'vim' -c "$TARGET_DIR" "nvim; zsh"

  # Create the remaining windows with specific names
  tmux new-window -t "$SESSION_NAME" -n 'copilot' -c "$TARGET_DIR" "opencode; zsh"
  tmux new-window -t "$SESSION_NAME" -n 'git'     -c "$TARGET_DIR" "lazygit; zsh"
  tmux new-window -t "$SESSION_NAME" -n 'console' -c "$TARGET_DIR"

  # Select the first window (vim) so you land there upon attaching
  tmux select-window -t "$SESSION_NAME:1"
}
