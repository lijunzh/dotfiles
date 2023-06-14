#!/bin/bash

################################################################################
# homebrew
################################################################################
brew update

# basic sh utils
brew install \
	bat \
	cmake \
	cmake-docs \
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
	zsh-syntax-highlighting

# developer sh utils
brew install \
  alacritty \
	tmux \
	poetry \
	pre-commit \
	git \
	git-delta \
	pyenv \
	pyenv-virtualenv \
	gpg

# font 
brew tap homebrew/cask-fonts 
brew install --cask font-fira-code-nerd-font

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
