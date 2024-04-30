return {
	view = {
		adaptive_size = true,
	},
	filters = {
		dotfiles = true,
		custom = { "node_modules" },
	},
	git = {
		enable = true,
		ignore = true,
	},
	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}
