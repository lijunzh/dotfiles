if hash fzf 2>/dev/null; then

	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

	# Configuration
	# export FZF_DEFAULT_COMMAND='rg --files --hidden --ignore-case'
	export FZF_DEFAULT_COMMAND="fd --hidden --exclude '.git' . $HOME"
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
	export FZF_ALT_C_COMMAND="fd -t d . $HOME"
	export FZF_DEFAULT_OPTS='
		--multi --layout=reverse --border --inline-info
		--bind ctrl-f:page-down,ctrl-b:page-up
		--preview "bat --color 'always' {}"'
fi;
