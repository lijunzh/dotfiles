# ============================================================================
# Lijun Zhu's Zsh Configuration
# ============================================================================
# Simplified configuration for macOS - relies on sensible defaults
# Adapted from thoughtbot/dotfiles

# ============================================================================
# Shell Options
# ============================================================================

# History
setopt hist_ignore_all_dups        # Remove older duplicate entries from history
setopt inc_append_history          # Append to history immediately
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# Directory navigation
setopt autocd                      # cd by typing directory name if it's not a command
setopt autopushd                   # Make cd push old directory to directory stack
DIRSTACKSIZE=5

# Globbing
setopt extendedglob                # Extended globbing (allows regex-like patterns)

# Other options
setopt nobeep                      # No beep
setopt prompt_subst                # Enable substitution for prompt

# ============================================================================
# Completion
# ============================================================================

# Completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump
else
  compinit -C
fi

# Disable mtools command mcd which causes a conflict
compdef -d mcd

# Define completion for g function (use git's completion)
compdef g=git

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ============================================================================
# Keybindings
# ============================================================================

# Give us access to ^Q
stty -ixon

# Vi mode
bindkey -v
bindkey "^F" vi-cmd-mode

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Essential keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward

# ============================================================================
# Environment Variables
# ============================================================================

# Editor
if hash nvim 2>/dev/null; then
  export VISUAL=nvim
fi
export EDITOR=$VISUAL

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# GnuPG
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# ============================================================================
# Path
# ============================================================================

# Add /usr/local/sbin to PATH
PATH="/usr/local/sbin:$PATH"

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH

# ============================================================================
# Functions
# ============================================================================

# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

# Make directory and change into it
mcd() {
  mkdir -p "$1" && cd "$1"
}

# ============================================================================
# Aliases
# ============================================================================

# ls (using eza if available)
type eza >/dev/null 2>&1 && alias ls="eza --icons --group-directories-first"
alias ll="ls -alF"

# Safe operations
alias mkdir="mkdir -p"
alias ln="ln -v"
alias cp="cp -i"
alias df="df -h"

# Navigation
alias -- -="cd -"

# Editor
type nvim >/dev/null 2>&1 && alias vim="nvim"

# Utilities
alias path='echo $PATH | tr -s ":" "\n"'

# ============================================================================
# Prompt (Starship)
# ============================================================================

eval "$(starship init zsh)"

# ============================================================================
# Local Customizations
# ============================================================================

# Source local configuration files if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
