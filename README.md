# Lijun Zhu's dotfiles
Cross-platform dot files python/bash development. 

This repo is adapted from [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles).

## Prerequisites

* Temporarily get `sudo` privileges.
* Install XCode Command Line Tools by running `xcode-select --install`.
* [Optional] Choose a [Nerd Font](https://www.nerdfonts.com/) in your terminal emulator. Fira-code Nerd Font will be installed by default via homebrew-cask-fonts.
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

## Post Installation
Restart the terminal, and enter `vim`. This should trigger the `PackerIntall` automatically. If not, type `PackerSync` in the `vim` command. Once all the plugins are installed, you can type `MasonInstallAll` (should have autocompleted for you) to install all the LSP servers.  
