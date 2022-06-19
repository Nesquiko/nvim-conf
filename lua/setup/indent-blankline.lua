-- indent_blankline.lua
-- Config file for lukas-reineke/indent-blankline.nvim
--
-- @see h: indent-blankline-variables for explanation
-- of each entry in setup table.
-- NOTE: To convert from vimscript to lua, only remove
-- indent_blankline_ prefix.

local indent_blankline = require("indent_blankline")

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

indent_blankline.setup({
	char = "▏",
	char_blankline = "▏",
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
	use_treesitter = true,
	filetype_exclude = {
		"lspinfo",
		"packer",
		"checkhealth",
		"help",
		"man",
		"NvimTree",
		"Trouble",
	},
	buftype_exclude = { "terminal", "nofile", "quickfix" },
	show_current_context = true,
	show_current_context_start = true,
	-- use_treesitter_scope = true, NOTE: doesnt work, selects top of this file as context start
	context_patterns = {
		"class",
		"return",
		"function",
		"method",
		"^if",
		"^while",
		"jsx_element",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
		"if_statement",
		"else_clause",
		"jsx_element",
		"jsx_self_closing_element",
		"try_statement",
		"catch_clause",
		"import_statement",
		"operation_type",
	},
})
