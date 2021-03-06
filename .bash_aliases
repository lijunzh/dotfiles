# ls alias
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias mkdir="mkdir -p"
alias ln="ln -v"

# cd shortcuts
alias ..="cd .."

# git shortcuts
alias g="git"
__git_complete g _git		# force git completion
alias c="config"
__git_complete c _git		# force git completion

# use neovim instead of vim
type nvim >/dev/null 2>&1 && alias vim="nvim"

# use dtach and nvim together
alias v="dtach -A /tmp/dtach-nvim -r winch nvim"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# source conda
alias sa="conda activate"
alias sd="conda deactivate"

# Include custom aliases
[[ -f ~/.bash_aliases.local ]] && source ~/.bash_aliases.local
