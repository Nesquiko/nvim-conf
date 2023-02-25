-- init.lua
--
-- Main config file for nvim.
--
-- RESPONSIBLE_FOR:
-- 	Loading of non-plugin core config files.
-- 	Loading of plugin specific config files.

require("core.keymaps")
require("core.options")
require("plugin.packer")
local plugin_loader = require("core.config_loader")
plugin_loader:load_configs({
	"plugin.config.colorscheme",
	"plugin.config.cmp",
	"plugin.config.lsp",
	"plugin.config.telescope",
	"plugin.config.treesitter",
	--[[ "plugin.config.autopairs", ]]
	"plugin.config.comment",
	"plugin.config.gitsigns",
	"plugin.config.nvim-tree",
	"plugin.config.bufferline",
	"plugin.config.toggleterm",
	"plugin.config.lualine",
	"plugin.config.project",
	"plugin.config.impatient",
	"plugin.config.indent-blankline",
	"plugin.config.alpha",
	"plugin.config.yabs",
	"plugin.config.debugger",
	"plugin.config.trouble",
	"plugin.config.luasnip",
	"plugin.config.vugu",
	"plugin.config.copilot",
	--[[ "plugin.config.rust-tools", ]]
})
