# Lijun Zhu's dotfiles

macOS dotfiles for Python, Rust, and Markdown workflows. This repository features a streamlined development environment with Neovim (NvChad), tmux, Zsh, and essential CLI utilities.

This repo is adapted from [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles).

## Features

- **Neovim**: Pure Lua configuration (~840 lines total)
  - LSP support via Mason (Rust, Python, Lua, Bash, YAML, JSON, LaTeX, C/C++)
  - Treesitter for syntax highlighting and incremental selection
  - Telescope for fuzzy finding (files, grep, buffers)
  - Conform for code formatting
  - Gruvbox colorscheme
  
- **Terminal**: 
  - Custom Zsh configuration with plugins
  - Alacritty terminal configuration
  - Tmux setup for session management
  
- **Git**: 
  - Enhanced configuration with useful aliases and modern defaults
  - Delta for improved diffs with side-by-side view
  - GPG signing setup
  - Conventional commit message template
  - Comprehensive global gitignore
  
- **CLI Tools**:
  - Modern replacements: bat, eza, ripgrep, fd, fzf
  - Git utilities (git-delta, lazygit)
  - uv for fast Python package management

## Prerequisites

* macOS system
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
```

Mason will automatically install LSP servers on first use. To manually install:
```vim
:Mason
```

## Key Configurations

### Neovim
Pure Lua configuration without frameworks (~840 lines):
```
config/nvim/
├── init.lua              # Entry point, lazy.nvim bootstrap
└── lua/
    ├── core/
    │   ├── options.lua   # Vim options
    │   ├── keymaps.lua   # Keybindings
    │   └── autocmds.lua  # Autocommands
    └── plugins/
        ├── init.lua      # Plugin specs (telescope, mason, conform, cmp)
        ├── lsp.lua       # LSP configuration
        └── treesitter.lua
```

**Key features:**
- **LSP**: rust_analyzer (clippy), lua_ls, ruff, bashls, taplo, texlab, yamlls, jsonls, clangd
- **Formatting**: stylua, ruff_format, rustfmt, shfmt, deno_fmt, yamlfmt, prettier
- **Keybindings**: `<leader>ff` find files, `<leader>fg` grep, `<leader>fm` format, `gd` go to definition

### Zsh
- **Single file configuration**: All settings, functions, and aliases in `zshrc` (~150 lines)
- **Minimal and native**: Relies on sensible defaults, removes redundant options
- **Vi mode**: Fast transitions with essential keybindings
- **Functions**: `g` (git status/git shortcut) and `mcd` (mkdir + cd)

### Tmux
- **Modern configuration** for tmux 3.6+
- **Vi-style navigation**: `h/j/k/l` for pane selection
- **Intuitive splits**: `Prefix v` or `Prefix |` for horizontal, `Prefix s` or `Prefix -` for vertical
- **Smart defaults**: Windows/panes start at 1, preserve current directory
- **Enhanced features**: 50K line history, undercurl support, true color

#### Tmux Key Bindings
**Prefix**: `Ctrl-b` (or `Ctrl-a` as secondary)

| Keybinding | Action |
|------------|--------|
| `Prefix r` | Reload config |
| `Prefix e` | Edit config |
| `Prefix c` | New window (current directory) |
| `Prefix C` | New window with rename |
| `Prefix v` or `Prefix \|` | Split horizontal |
| `Prefix s` or `Prefix -` | Split vertical |
| `Prefix h/j/k/l` | Navigate panes |
| `Prefix H/J/K/L` | Resize panes |
| `Prefix z` | Toggle pane zoom |
| `Prefix t` | Toggle status bar |
| `Prefix C-l` | Clear screen + history |
| `Prefix Enter` | Copy mode |

**Copy Mode** (Vi-style):
- `v` - Begin selection
- `C-v` - Rectangle selection
- `y` - Copy and exit
- `H/L` - Start/end of line

### Git
- **Modern defaults**: `main` as default branch, `pull.rebase = true`, auto-setup remote tracking
- **Enhanced diff**: Uses `delta` with side-by-side view and line numbers
- **Better merges**: `zdiff3` conflict style for clearer conflict resolution
- **Auto-correct**: Typos automatically corrected after 1 second
- **Smart sorting**: Branches sorted by recent commits, tags by version

#### Git Aliases
**Quick Commands**:
| Alias | Command | Description |
|-------|---------|-------------|
| `git s` | `status -s` | Short status |
| `git l` | `log --graph` | Graph log (20 commits) |
| `git lg` | Pretty log | Colorful graph with author |
| `git d` | `diff` | Show diff |
| `git last` | Last commit | Show last commit with stats |

**Workflow**:
| Alias | Command | Description |
|-------|---------|-------------|
| `git cm <msg>` | `commit -m` | Quick commit |
| `git cam <msg>` | `commit -am` | Add all + commit |
| `git ca` | Add all + commit | Interactive commit |
| `git amend` | Amend commit | Fix last commit |
| `git undo` | Reset soft | Undo last commit, keep changes |

**Branch Management**:
| Alias | Command | Description |
|-------|---------|-------------|
| `git nb <name>` | `checkout -b` | New branch |
| `git go <name>` | Smart checkout | Checkout or create branch |
| `git current` | Current branch | Show current branch name |
| `git branches` | List all | Show all branches |
| `git dm` | Delete merged | Remove merged branches |
| `git cleanup` | Prune branches | Delete branches removed on remote |

**Search & Analysis**:
| Alias | Command | Description |
|-------|---------|-------------|
| `git fc <text>` | Find commits | Search by source code |
| `git fm <text>` | Find commits | Search by commit message |
| `git fb <commit>` | Find branches | Branches containing commit |
| `git contributors` | Shortlog | List contributors with counts |

**Stash**:
| Alias | Command | Description |
|-------|---------|-------------|
| `git stash-all` | Stash untracked | Stash everything including untracked |
| `git stashes` | Pretty list | Show all stashes nicely formatted |

**Other**:
| Alias | Command | Description |
|-------|---------|-------------|
| `git ignored` | List ignored | Show files ignored by git |
| `git aliases` | List aliases | Show all git aliases |

#### Git URL Shortcuts
| Shortcut | Expands to | Example |
|----------|------------|---------|
| `gh:` | `git@github.com:` | `git clone gh:user/repo` |
| `github:` | `git://github.com/` | `git clone github:user/repo` |
| `gst:` | `git@gist.github.com:` | `git clone gst:user/gist-id` |
| `gist:` | `git://gist.github.com/` | `git clone gist:user/gist-id` |

#### Git Commit Template
Uses conventional commit format. When you run `git commit`, you'll see a template with:
- **Types**: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- **Format**: `<type>(<scope>): <subject>` (max 50 chars)
- **Body**: Wrapped at 72 chars, explains WHAT and WHY
- **Footer**: Issue references, breaking changes, co-authors

Example:
```
feat(api): add JWT token validation

Implement JWT token validation middleware to secure API endpoints.
Uses the jsonwebtoken library for token verification.

Fixes #123
```

### GnuPG
- GPG configuration in `gnupg/` directory
- Agent configuration for GPG signing

## Repository Structure

```
dotfiles/
├── Brewfile                # Homebrew package definitions
├── install.sh              # Main installation script
├── rcrc                    # rcm configuration
├── config/
│   └── nvim/               # Neovim configuration (pure Lua)
│       ├── init.lua
│       └── lua/
│           ├── core/       # options, keymaps, autocmds
│           └── plugins/    # plugin specs, lsp, treesitter
├── gnupg/                  # GnuPG configuration
├── alacritty.toml          # Alacritty terminal config
├── tmux.conf               # Tmux configuration (tmux 3.6+)
├── gitconfig               # Git configuration with modern defaults
├── gitignore               # Global Git ignore (comprehensive)
├── gitmessage              # Git commit template (conventional commits)
└── zshrc                   # Zsh configuration (all-in-one)
```

## Customization

To customize this setup:
1. **Personal Git settings**: Create `~/.gitconfig.local`:
   ```bash
   [user]
       name = Your Name
       email = your.email@example.com
       signingkey = YOUR_GPG_KEY_ID
   ```
2. **Homebrew packages**: Edit `Brewfile` to add/remove packages
3. **Neovim LSP/formatters**: Modify `config/nvim/lua/configs/mason.lua`
4. **Shell customizations**: Create `~/.zshrc.local` for machine-specific settings
5. **Terminal settings**: Adjust `alacritty.toml` for Alacritty
6. **Tmux settings**: Modify `tmux.conf` or create `~/.tmux.conf.local`
7. **Git workflow**: Edit `gitmessage` to customize commit template

## Quick Tips

### Git Workflow
```bash
# Clone repos faster with shortcuts
git clone gh:user/repo

# Auto-correct typos (waits 1 second)
git stauts  # Automatically becomes 'git status'

# Quick commits
git cm "feat: add new feature"
git cam "fix: resolve bug"

# View beautiful logs
git lg
git last

# Clean up branches
git cleanup  # Remove local branches deleted on remote
git dm       # Delete branches already merged

# Stash everything
git stash-all
git stashes  # Pretty list of stashes
```

### Tmux Workflow
```bash
# Start new session
tmux new -s work

# Inside tmux:
# Prefix v        - Split right
# Prefix s        - Split down
# Prefix hjkl     - Navigate panes
# Prefix z        - Zoom pane
# Prefix t        - Toggle status bar
# Prefix Enter    - Copy mode (then v to select, y to copy)
```

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

### Git delta not showing colors
1. Install delta: `brew install git-delta`
2. Verify in `~/.gitconfig`: `pager.diff = delta`
3. Test with: `git diff` or `git log -p`

### Tmux config not loading
1. Reload config: `Prefix r` (or `tmux source ~/.tmux.conf`)
2. Check tmux version: `tmux -V` (should be 3.0+)
3. Kill and restart tmux server: `tmux kill-server && tmux`

## License

This repository is provided as-is for personal use. Feel free to fork and adapt to your needs.

## Acknowledgments

- [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles) - Original inspiration and rcm usage
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - Colorscheme