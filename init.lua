-- init.lua
-- Main config file for nvim. Every initialization is called with in a pcall,
-- so if one plugin fails, nvim is still loaded. When an error occurs, a log
-- file is created in ./log dir.

local plugin_loader = require("core.config_loader")

local ok, err = pcall(require, "setup.keymaps")
ok, err = pcall(require, "setup.options")
ok, err = pcall(require, "setup.plugins")

plugin_loader:load_configs({
	"setup.colorscheme",
	"setup.cmp",
	"setup.lsp",
	"setup.telescope",
	"setup.treesitter",
	"setup.autopairs",
	"setup.comment",
	"setup.gitsigns",
	"setup.nvim-tree",
	"setup.bufferline",
	"setup.toggleterm",
	"setup.lualine",
	"setup.project",
	"setup.impatient",
	"setup.indent-blankline",
	"setup.alpha",
	"setup.yabs",
})

-- require("setup.debugger")
