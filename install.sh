#!/bin/bash

################################################################################
# homebrew
################################################################################
if ! command -v which -s brew &> /dev/null ; then
	# Install Homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	brew update
fi

# basic sh utils
brew install \
	bat \
	cmake \
	exa \
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
	git \
	git-delta \
	zsh-syntax-highlighting

# developer sh utils
brew install \
	tmux \
	poetry \
	pre-commit \
	git-delta \
	pyenv \
  pyenv-virtualenv \
	gpg

# editor
brew install \
	llvm \
	lua \
	node \
  go \
	neovim

################################################################################
# rust
################################################################################
if ! command -v which -s rustup &> /dev/null ; then
	# Install Homebrew
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
	rustup update
fi

################################################################################
# neovim
################################################################################
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

################################################################################
# dotfiles
################################################################################
rcup -d . -v
