#!/usr/bin/env zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "💻 Setting up macOS..."
echo "⚠️ This will require a reboot after completion."
echo ""

ask_confirmation() {
  local prompt="$1"
  while true; do
    read -p "${prompt} (y/n): " yn
    case $yn in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer yes (y) or no (n)." ;;
    esac
  done
}

# ---- Configure Keyboard ------------

if ask_confirmation "⌨️ Configure keyboard settings?"; then
  echo "⌨️ Configuring keyboard..."

  # Repeat character while key held (https://macos-defaults.com/keyboard/applepressandholdenabled.html#set-to-false)
  defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"

  # Set key repeat speed (https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x)
  defaults write -g InitialKeyRepeat -float 13.0 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -float 1.8         # normal minimum is 2 (30 ms)

  # Set fn key usage to emoji & symbols (https://macos-defaults.com/keyboard/applefnusagetype.html)
  defaults write com.apple.HIToolbox AppleFnUsageType -int "2"

  # Enable window dragging via ctrl + cmd (https://www.geekbitzone.com/posts/2022/macos/hacks/ui-window-shortcuts/click-drag-windows-anywhere/)
  defaults write -g NSWindowShouldDragOnGesture -bool true

  echo -e "${GREEN}✓ Keyboard configured${NC}"
else
  echo "⏭️ Skipping keyboard configuration"
fi

# ---- Configure Mouse ---------------

if ask_confirmation "🐭 Configure mouse settings?"; then
  echo "🐭 Configuring mouse..."

  # Set mouse speed (https://macos-defaults.com/mouse/scaling.html)
  defaults write NSGlobalDomain com.apple.mouse.scaling -float "1"

  echo -e "${GREEN}✓ Mouse configured${NC}"
else
  echo "⏭️ Skipping mouse configuration"
fi

# ---- Configure Dock ----------------

if ask_confirmation "☑️ Configure dock settings?"; then
  echo "☑️ Configuring dock..."

  # Set tilesize (https://macos-defaults.com/dock/tilesize.html)
  defaults write com.apple.dock "tilesize" -int "40"

  # Set magnified size (no ref)
  defaults write com.apple.dock "largesize" -int "48"

  # Enable magnification (no ref)
  defaults write com.apple.dock magnification -bool true

  # Set minimize effect (https://macos-defaults.com/dock/mineffect.html)
  defaults write com.apple.dock "mineffect" -string "scale"

  # Speed up autohide animation time (https://macos-defaults.com/dock/autohide-time-modifier.html)
  defaults write com.apple.dock "autohide-time-modifier" -float "0.5"

  # Disable autohide delay (https://macos-defaults.com/dock/autohide-delay.html)
  defaults write com.apple.dock "autohide-delay" -float "0"

  killall Dock

  echo -e "${GREEN}✓ Dock configured${NC}"
else
  echo "⏭️ Skipping dock configuration"
fi

# ---- Homebrew (https://brew.sh) ----

if command -v brew &>/dev/null; then
  echo "🍺 Homebrew is already installed"
else
  echo "🍺 Installing Homebrew..."

  # Install Homebrew (https://brew.sh)
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add shellenv to the .zshenv
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>.zshenv

  # Run shellenv in current context
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ---- UV (github.com/astral-sh/uv) --

if command -v uv &>/dev/null; then
  echo "🐍 UV is already installed"
else
  echo "🐍 Installing UV..."

  # Install UV
  curl -LsSf https://astral.sh/uv/install.sh | sh

  echo -e "${GREEN}✓ UV installed${NC}"
fi

# ---- Tools ---------------------

if command -v brew &>/dev/null; then
  if ask_confirmation "🍺 Install neccesary development tools via Homebrew?"; then
    echo "🍺 Installing tools..."

    # Install tools that can not be installed by mise
    brew install mise php watchman wget xcodegen

    echo -e "${GREEN}✓ Tools installed${NC}"
  else
    echo "⏭️ Skipping tool installation"
  fi
else
  echo -e "${YELLOW}⚠️ Homebrew not available, skipping tool installation${NC}"
fi

# ---- Git -----------------------

if command -v gh &>/dev/null; then
  if ask_confirmation "📦 Authenticate git with GitHub?"; then
    echo "📦 Authenticating with GitHub..."

    # Authenticate with GitHub
    gh auth login -p https -w

    echo -e "${GREEN}✓ GitHub authenticated${NC}"
  else
    echo "⏭️ Skipping GitHub authentication"
  fi
else
  echo -e "${YELLOW}⚠️ GitHub CLI not available, skipping authentication${NC}"
fi

# ---- Dotfiles ------------------

if command -v gh &>/dev/null; then
  if gh auth status &>/dev/null; then
    GITHUB_USERNAME=$(gh api user -q .login)

    if [ -n "$GITHUB_USERNAME" ]; then
      if ask_confirmation "☁️ Apply dotfiles from GitHub repo (github.com/${GITHUB_USERNAME}/.config)?"; then
        echo "☁️ Applying dotfiles..."

        # Clone .config repo
        gh repo clone $GITHUB_USERNAME/.config $HOME/.config

        # Symlink zsh (the rest can be symlinked by hand)
        ln -s $HOME/.config/zsh/.zshrc $HOME/.zshrc
        ln -s $HOME/.config/zsh/.zshenv $HOME/.zshenv

        echo -e "${GREEN}✓ Dotfiles applied${NC}"
      else
        echo "⏭️ Skipping dotfiles"
      fi
    else
      echo -e "${YELLOW}⚠️ Could not retrieve GitHub username, skipping dotfiles${NC}"
    fi
  else
    echo -e "${YELLOW}⚠️ GitHub CLI not authenticated, skipping dotfiles${NC}"
  fi
else
  echo -e "${YELLOW}⚠️ GitHub CLI not available, skipping dotfiles${NC}"
fi
