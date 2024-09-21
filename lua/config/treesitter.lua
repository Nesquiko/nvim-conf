require("ts_context_commentstring").setup({})
vim.g.skip_ts_context_commentstring_module = true
require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = false },
})
