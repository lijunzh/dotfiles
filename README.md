# Lijun Zhu's dotfiles
Cross-platform dot files python/bash development. 

This repo is adapted from [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles).

## Prerequisites

* Temporarily get `sudo` privileges.
* Install XCode Command Line Tools by running `xcode-select --install`.
* Use a [Nerd Font](https://www.nerdfonts.com/) in your terminal emulator.
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
