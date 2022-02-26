# load our own completion functions
fpath=(~/.zsh/completion $fpath)
if hash brew 2>/dev/null; then
	fpath=($(brew --prefix)/share/zsh-completions $fpath)
	fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
	source $(brew --prefix)/share/zsh-syntax-highlighting
fi;

# completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
	compinit -d $HOME/.zcompdump;
else
	compinit -C;
fi;

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd
