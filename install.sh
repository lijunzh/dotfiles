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
  echo "Error: Homebrew is required. Install it from https://brew.sh/"
  exit 1
fi

echo "Updating Homebrew..."
brew update

# Basic shell utilities
echo "Installing basic shell utilities..."
brew install \
  bat \
  eza \
  fd \
  fzf \
  htop \
  rcm \
  ripgrep \
  rsync \
  tree \
  wget \
  zsh-completions \
  zsh-syntax-highlighting \
  starship

# Developer tools
echo "Installing developer tools..."
brew install \
  alacritty \
  cmake \
  git \
  git-delta \
  gpg \
  llvm \
  neovim \
  pinentry-mac \
  poetry \
  pre-commit \
  pyenv \
  pyenv-virtualenv \
  tmux

# Font
echo "Installing Nerd Fonts..."
brew install --cask font-fira-mono-nerd-font

################################################################################
# Rust
################################################################################
echo "Setting up Rust..."
if ! command -v rustup &> /dev/null; then
  echo "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
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
