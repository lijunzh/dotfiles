#!/bin/bash

set -e

echo "==== Installing dotfiles ===="

################################################################################
# Platform detection
################################################################################
PLATFORM="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="macos"
  echo "Detected macOS platform"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  PLATFORM="linux"
  echo "Detected Linux platform"
fi

################################################################################
# homebrew (macOS only)
################################################################################
if [[ "$PLATFORM" == "macos" ]]; then
  echo "Updating Homebrew..."
  brew update

  # basic sh utils
  echo "Installing basic shell utilities..."
  brew install \
    bat \
    cmake \
    cmake-docs \
    eza \
    fd \
    ffmpeg \
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

  # developer sh utils
  echo "Installing developer tools..."
  brew install \
    alacritty \
    tmux \
    poetry \
    pre-commit \
    git \
    git-delta \
    pyenv \
    pyenv-virtualenv \
    gpg \
    biome

  # font
  echo "Installing Nerd Fonts..."
  brew install --cask font-fira-mono-nerd-font

  # editor
  echo "Installing development languages and editors..."
  brew install \
    llvm \
    lua \
    node \
    go \
    deno \
    ruby \
    neovim

  # Ruby path setup - create zshrc.local if it doesn't exist
  RUBY_PATH_EXPORT='export PATH="/opt/homebrew/opt/ruby/bin:$PATH"'
  if [[ -d "/opt/homebrew/opt/ruby" ]]; then
    # Apple Silicon path
    touch ~/.zshrc.local
    if ! grep -q "$RUBY_PATH_EXPORT" ~/.zshrc.local; then
      echo "$RUBY_PATH_EXPORT" >> ~/.zshrc.local
    fi
  elif [[ -d "/usr/local/opt/ruby" ]]; then
    # Intel Mac path
    touch ~/.zshrc.local
    if ! grep -q 'export PATH="/usr/local/opt/ruby/bin:$PATH"' ~/.zshrc.local; then
      echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc.local
    fi
  fi
elif [[ "$PLATFORM" == "linux" ]]; then
  echo "Linux detected. Installing packages for your distribution..."
  
  # Detect the Linux distribution
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
  fi
  
  case $DISTRO in
    debian|ubuntu|pop)
      echo "Debian/Ubuntu-based distribution detected"
      sudo apt update
      
      # Install basic utilities
      echo "Installing basic utilities..."
      sudo apt install -y \
        bat \
        fd-find \
        ffmpeg \
        fzf \
        htop \
        python3-pip \
        ripgrep \
        rsync \
        tree \
        wget \
        zsh \
        curl \
        git
      
      # Install development tools
      echo "Installing development tools..."
      sudo apt install -y \
        build-essential \
        cmake \
        tmux \
        neovim \
        pre-commit \
        python3-venv \
        gnupg2
      
      # Install RCM (might need to be downloaded separately)
      if ! command -v rcup &> /dev/null; then
        echo "Installing RCM..."
        TEMP_DEB=$(mktemp)
        wget -O $TEMP_DEB https://thoughtbot.github.io/rcm/debs/rcm_1.3.4-1_all.deb
        sudo dpkg -i $TEMP_DEB
        rm $TEMP_DEB
      fi
      
      # Install starship if not available in repo
      if ! command -v starship &> /dev/null; then
        echo "Installing starship prompt..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
      fi
      
      # Symlink for bat on Debian/Ubuntu
      if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
        echo "Creating bat symlink..."
        mkdir -p ~/.local/bin
        ln -sf /usr/bin/batcat ~/.local/bin/bat
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc.local
      fi
      ;;
      
    fedora|rhel|centos|rocky)
      echo "Fedora/RHEL-based distribution detected"
      sudo dnf update -y
      
      # Install basic utilities
      echo "Installing basic utilities..."
      sudo dnf install -y \
        bat \
        fd-find \
        ffmpeg \
        fzf \
        htop \
        python3-pip \
        ripgrep \
        rsync \
        tree \
        wget \
        zsh \
        curl \
        git
      
      # Install development tools
      echo "Installing development tools..."
      sudo dnf install -y \
        cmake \
        gcc \
        gcc-c++ \
        make \
        tmux \
        neovim \
        pre-commit \
        python3-devel \
        gnupg2
      
      # Install RCM
      if ! command -v rcup &> /dev/null; then
        echo "Installing RCM..."
        sudo dnf copr enable braderhart/rcm -y
        sudo dnf install -y rcm
      fi
      
      # Install starship if needed
      if ! command -v starship &> /dev/null; then
        echo "Installing starship prompt..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
      fi
      ;;
      
    arch|manjaro)
      echo "Arch-based distribution detected"
      sudo pacman -Syu
      
      # Install basic utilities
      echo "Installing basic utilities..."
      sudo pacman -S --needed --noconfirm \
        bat \
        fd \
        ffmpeg \
        fzf \
        htop \
        python-pip \
        ripgrep \
        rsync \
        tree \
        wget \
        zsh \
        curl \
        git
      
      # Install development tools
      echo "Installing development tools..."
      sudo pacman -S --needed --noconfirm \
        cmake \
        base-devel \
        tmux \
        neovim \
        python \
        gnupg
      
      # Install rcm from AUR
      if ! command -v rcup &> /dev/null; then
        echo "Installing RCM from AUR..."
        if ! command -v yay &> /dev/null; then
          echo "Installing yay AUR helper first..."
          git clone https://aur.archlinux.org/yay.git /tmp/yay
          cd /tmp/yay
          makepkg -si --noconfirm
          cd -
        fi
        yay -S --noconfirm rcm
      fi
      
      # Install starship
      if ! command -v starship &> /dev/null; then
        echo "Installing starship prompt..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
      fi
      ;;
      
    *)
      echo "Unsupported Linux distribution. Please install packages manually:"
      echo "Required: git, rcm (or stow), neovim, tmux, zsh, curl, and others"
      echo "After installing the required packages, run 'rcup -d . -v' to install dotfiles"
      ;;
  esac
  
  # Install pyenv for all Linux distributions
  if ! command -v pyenv &> /dev/null; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash
  fi
fi

################################################################################
# rust
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
# dotfiles
################################################################################
echo "Installing dotfiles with rcup..."
rcup -d . -v

echo "==== Installation complete! ===="
echo "Please restart your shell or source your ~/.zshrc to apply changes."
echo "To complete Neovim setup, open Neovim and run :Lazy sync and :MasonInstallAll"
