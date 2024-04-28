# Lijun Zhu's dotfiles
Cross-platform dot files python/bash development. 

This repo is adapted from [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles).

## Prerequisites

* Temporarily get `sudo` privileges.
* [Optional] Choose a [Nerd Font](https://www.nerdfonts.com/) in your terminal emulator. Fira-Mono Nerd Font will be installed by default via homebrew-cask-fonts.
* [Optional] [Smart Caps Lock: Remap to Control AND Escape](https://gist.github.com/tanyuan/55bca522bf50363ae4573d4bdcf06e2e)

### MacOS Only
* Install XCode Command Line Tools by running `xcode-select --install`.
* Install [Homebrew](https://brew.sh/) and restart the shell.

## Installation

Clone this repo to the destination directory (default: `~/repo`)
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

Run the installation script
```
bash install.sh
```
