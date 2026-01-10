#!/bin/bash

set -e

echo "==== Installing dotfiles ===="

################################################################################
# Verify macOS
################################################################################
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "Error: This dotfiles repository only supports macOS."
  exit 1
fi

################################################################################
# Homebrew
################################################################################
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  echo "Homebrew installed successfully!"
else
  echo "Homebrew already installed."
fi

echo "Updating Homebrew..."
brew update

echo "Installing packages from Brewfile..."
brew bundle --file=Brewfile

################################################################################
# Rust
################################################################################
echo "Setting up Rust..."
if ! command -v rustup &> /dev/null; then
  echo "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

  # Source cargo environment
  source "$HOME/.cargo/env"
else
  echo "Updating existing Rust installation..."
  rustup update
fi

################################################################################
# Dotfiles
################################################################################
echo "Installing dotfiles with rcup..."
rcup -d . -v

echo "==== Installation complete! ===="
echo ""
echo "Next steps:"
echo "  1. Restart your shell or run: source ~/.zshrc"
echo "  2. Open Neovim and run: :Lazy sync"
echo "  3. In Neovim, run: :MasonInstallAll"
