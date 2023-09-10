-- treesitter.language
-- File for configuring treesitter.
-- Also a config for nvim-ts-rainbow is in table called rainbow.

local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = false, disable = { "" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
