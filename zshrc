# ============================================================================
# Lijun Zhu's Zsh Configuration
# ============================================================================
# A simplified, consolidated configuration for macOS
# Adapted from thoughtbot/dotfiles

# ============================================================================
# Shell Options
# ============================================================================

# History
setopt hist_ignore_all_dups        # Remove older duplicate entries from history
setopt inc_append_history          # Append to history immediately
setopt appendhistory               # Append history instead of overwriting
setopt histignorealldups           # If a new command is a duplicate, remove the older one
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# Directory navigation
setopt autocd                      # cd by typing directory name if it's not a command
setopt autopushd                   # Make cd push old directory to directory stack
setopt pushdminus                  # Swap meanings of +/- when navigating directory stack
setopt pushdsilent                 # Don't print directory stack after pushd/popd
setopt pushdtohome                 # pushd with no arguments goes to home directory
setopt cdablevars                  # Change directory to a path stored in a variable
DIRSTACKSIZE=5

# Globbing and pattern matching
setopt extendedglob                # Extended globbing (allows using regular expressions with *)
setopt nocaseglob                  # Case insensitive globbing
setopt numericglobsort             # Sort filenames numerically when it makes sense
unsetopt nomatch                   # Allow [ or ] wherever you want

# Other options
setopt correct                     # Auto correct mistakes
setopt rcexpandparam               # Array expansion with parameters
setopt nocheckjobs                 # Don't warn about running processes when exiting
setopt nobeep                      # No beep
setopt prompt_subst                # Enable substitution for prompt

# Word characters (don't consider certain characters part of the word)
WORDCHARS=${WORDCHARS//\/[&.;]}

# ============================================================================
# Colors
# ============================================================================

# Enable colored output
autoload -U colors
colors
export CLICOLOR=1

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# ============================================================================
# Completion
# ============================================================================

# Load completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# Completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump
else
  compinit -C
fi

# Disable zsh bundled function mtools command mcd which causes a conflict
compdef -d mcd

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion
zstyle ':completion:*' rehash true                          # Automatically find new executables
zstyle ':completion:*' accept-exact '*(N)'                  # Speed up completions
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

# Handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^Q" push-line-or-edit
bindkey -s "^T" "^[Isudo ^[A"  # "t" for "toughguy"

# Updates editor information when the keymap changes
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select

# Vi mode prompt info
function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
}

# Define right prompt
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

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

# Erlang (for those using Erlang/Elixir)
export ERL_AFLAGS="-kernel shell_history enabled"

# ============================================================================
# Path
# ============================================================================

# Ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

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

# ls aliases (using eza if available)
type eza >/dev/null 2>&1 && alias ls="eza --icons --group-directories-first"
alias ll="ls -alF"

# Safe operations
alias mkdir="mkdir -p"     # Create parent directories if needed
alias ln="ln -v"           # Verbose ln
alias cp="cp -i"           # Confirm before overwriting
alias df="df -h"           # Human readable sizes

# Navigation
alias -- -="cd -"          # Previous directory

# Use neovim instead of vim
type nvim >/dev/null 2>&1 && alias vim="nvim"

# Pretty print the path
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
