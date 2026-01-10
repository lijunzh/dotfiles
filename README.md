# Lijun Zhu's dotfiles

macOS dotfiles for Python, Rust, and Markdown workflows. This repository features a streamlined development environment with Neovim (NvChad), tmux, Zsh, and essential CLI utilities.

This repo is adapted from [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles).

## Features

- **Neovim**: Configured with [NvChad](https://github.com/NvChad/NvChad) for a modern IDE experience
  - LSP support via Mason (Python, Rust, Lua)
  - LSP configurations with rust_analyzer (clippy integration) and lua_ls
  - GitHub Copilot integration
  - Formatting with conform.nvim (Prettier, deno_fmt for Markdown)
  - Treesitter for improved syntax highlighting
  
- **Terminal**: 
  - Custom Zsh configuration with plugins
  - Alacritty terminal configuration
  - Tmux setup for session management
  
- **Git**: 
  - Enhanced configuration with useful aliases
  - Delta for improved diffs
  - GPG signing setup
  
- **CLI Tools**:
  - Modern replacements: bat, eza, ripgrep, fd, fzf
  - Git utilities (git-delta, lazygit)
  - uv for fast Python package management

## Prerequisites

* macOS system (Linux support removed in Phase 3)
* Install XCode Command Line Tools: `xcode-select --install`
* Install [Homebrew](https://brew.sh/) and restart the shell
* [Optional] Choose a [Nerd Font](https://www.nerdfonts.com/) in your terminal emulator. Fira Code Nerd Font will be installed by default via homebrew-cask-fonts.
* [Optional] [Smart Caps Lock: Remap to Control AND Escape](https://gist.github.com/tanyuan/55bca522bf50363ae4573d4bdcf06e2e)

## Installation

### 1. Clone the repository
```bash
git clone https://github.com/lijunzh/dotfiles.git ~/repo/dotfiles
```

### 2. Run the installation script
```bash
cd ~/repo/dotfiles
bash install.sh
```

The installer will:
1. Verify macOS system
2. Install or update Homebrew
3. Install packages from Brewfile (in root directory)
4. Install or update Rust via rustup
5. Link configuration files using rcm (rcup)

### 3. Post-installation setup

After installation, restart your shell or run:
```bash
source ~/.zshrc
```

Then open Neovim and run:
```vim
:Lazy sync
:MasonInstallAll
```

This will install the language servers and formatters defined in `config/nvim/lua/configs/mason.lua`:
- **Language Servers**: rust_analyzer, pyright, lua_ls
- **Formatters**: prettier (general formatting), deno (Markdown via deno_fmt), stylua (Lua formatting)

## Phase 3 Changes

This repository has been streamlined to focus on macOS-only support with a simplified toolchain:

### What Changed
- **Platform Support**: Removed Linux support; macOS-only
- **Package Manager**: Homebrew for system tools, Mason for LSP/formatter tools
- **Python Tools**: Using `uv` instead of pyenv/poetry for faster Python workflows
- **Markdown Formatting**: Using deno_fmt (via Mason) for Obsidian notes, Prettier for general formatting
- **Font**: Changed from Fira Mono Nerd Font to Fira Code Nerd Font

### What Was Removed
- **Languages/Runtimes**: Node.js, Ruby, Go, Lua (system installs - using Mason for LSP tools instead)
- **Web Dev Tools**: Biome, web-dev specific LSPs (focused on Python/Rust/Lua only)
- **System Utils**: rsync, wget, tree, cmake, llvm
- **Python Tools**: poetry, pyenv, pyenv-virtualenv (replaced with uv)
- **Neovim Plugins**: peek.nvim (Markdown preview), markdown-related web LSPs
- **Zsh Functions**: change-extension, envup, _git_delete_branch

### What Was Kept
- **Core Zsh Functions**: `g` (git status), `mcd` (mkdir + cd)
- **GnuPG Configuration**: gnupg directory with gpg.conf and gpg-agent.conf
- **rcm**: Still using rcm for dotfile management
- **Core LSP Configs**: rust_analyzer and lua_ls configurations in lspconfig.lua

## Key Configurations

### Neovim
- **LSP Config**: `config/nvim/lua/configs/lspconfig.lua`
  - rust_analyzer with clippy integration and allFeatures enabled
  - lua_ls with proper Neovim globals and diagnostics
- **Mason**: `config/nvim/lua/configs/mason.lua`
  - Ensures installation of core language tools
- **Conform**: `config/nvim/lua/configs/conform.lua`
  - Prettier for HTML, CSS, JSON, YAML, Markdown
  - deno_fmt for Markdown (Obsidian workflow)
  - stylua for Lua files

### Zsh
- Custom functions in `zsh/functions/`: `g` (git status), `mcd` (mkdir + cd)
- Configuration in `zshrc` and `zshenv`
- Aliases in `aliases`

### GnuPG
- GPG configuration in `gnupg/` directory
- Agent configuration for GPG signing

## Repository Structure

```
dotfiles/
├── Brewfile                # Homebrew package definitions (root level)
├── install.sh              # Main installation script
├── rcrc                    # rcm configuration
├── config/
│   └── nvim/               # Neovim/NvChad configuration
├── gnupg/                  # GnuPG configuration
├── zsh/
│   └── functions/          # Custom Zsh functions (g, mcd)
├── alacritty.toml          # Alacritty terminal config
├── tmux.conf               # Tmux configuration
├── gitconfig               # Git configuration
├── gitignore               # Global Git ignore patterns
├── gitmessage              # Git commit message template
├── aliases                 # Shell aliases
├── zshenv                  # Zsh environment variables
└── zshrc                   # Zsh configuration
```

## Customization

To customize this setup:
1. Edit `Brewfile` (in root directory) to add/remove Homebrew packages
2. Modify `config/nvim/lua/configs/mason.lua` to change LSP/formatter installations
3. Update `zshrc`, `zshenv`, or `aliases` for shell customization
4. Add functions to `zsh/functions/` for custom shell functions
5. Adjust Alacritty settings in `alacritty.toml`
6. Modify tmux settings in `tmux.conf`

## Troubleshooting

### Neovim LSP not working
1. Ensure Mason tools are installed: `:MasonInstallAll` in Neovim
2. Check LSP status: `:LspInfo`
3. Verify Mason installations: `:Mason`

### Zsh not loading properly
1. Ensure Zsh is set as default shell: `chsh -s $(which zsh)`
2. Restart your terminal
3. Check for errors in `~/.zshrc` or `~/.zshenv`

### rcm symlinking issues
1. Check `rcrc` configuration file
2. Run `rcup -v` for verbose output
3. Ensure you cloned to `~/repo/dotfiles` or update `rcrc` accordingly

## License

This repository is provided as-is for personal use. Feel free to fork and adapt to your needs.

## Acknowledgments

- [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles) - Original inspiration and rcm usage
- [NvChad](https://github.com/NvChad/NvChad) - Neovim configuration framework