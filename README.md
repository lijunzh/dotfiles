# Lijun Zhu's dotfiles

Cross-platform dotfiles for Python, Rust, and web development. This repository features a comprehensive development environment with Neovim, tmux, Zsh, and various CLI utilities.

This repo is adapted from [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles).

## Features

- **Neovim**: Configured with [NvChad](https://github.com/NvChad/NvChad) for a modern IDE experience
  - LSP support for multiple languages (Python, Rust, Lua, etc.)
  - GitHub Copilot integration
  - Formatting with conform.nvim
  - Treesitter for improved syntax highlighting
  - Markdown preview with peek.nvim
  
- **Terminal**: 
  - Custom Zsh configuration with plugins
  - Alacritty terminal configuration
  - Tmux setup for session management
  
- **Git**: 
  - Enhanced configuration with useful aliases
  - Delta for improved diffs
  - GPG signing setup
  
- **CLI Tools**:
  - Modern replacements for common tools (bat, eza, ripgrep, fd)
  - Git utilities for workflow improvement

## Prerequisites

* Temporarily get `sudo` privileges (required for Linux installations)
* [Optional] Choose a [Nerd Font](https://www.nerdfonts.com/) in your terminal emulator. Fira-Mono Nerd Font will be installed by default via homebrew-cask-fonts on macOS.
* [Optional] [Smart Caps Lock: Remap to Control AND Escape](https://gist.github.com/tanyuan/55bca522bf50363ae4573d4bdcf06e2e)

### Platform-specific Requirements

#### macOS
* Install XCode Command Line Tools by running `xcode-select --install`.
* Install [Homebrew](https://brew.sh/) and restart the shell.

#### Linux 
The installer script supports the following Linux distributions:
* Debian/Ubuntu
* Fedora/RHEL/Rocky Linux
* Arch Linux/Manjaro

## Installation

### 1. Clone the repository
```
git clone https://github.com/lijunzh/dotfiles.git
```
If you use a directory other than the default one, please edit the `rcrc` file to customize:
* Change
```
DOTFILES_DIRS="$HOME/repo/dotfiles"
```
to
```
DOTFILES_DIRS="/YOUR/REPO/DIR/dotfiles"
```

### 2. Run the installation script
```
bash install.sh
```
