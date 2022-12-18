-- mason.lua
--
-- Configuration for mason plugin, which is a improved replacement for
-- Lsp-installer.

require("mason").setup()

local ensure_installed = {
	"sumneko_lua",
	"jsonls",
	"pyright",
	"gopls",
	"tsserver",
}

require("mason-lspconfig").setup({
	ensure_installed = ensure_installed,
})

local opts = {
	on_attach = require("plugin.config.lsp.handlers").on_attach,
	capabilities = require("plugin.config.lsp.handlers").capabilities,
}

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,

	-- Next, you can provide a dedicated handler for specific servers.
	["sumneko_lua"] = function()
		local sumneko_opts = require("plugin.config.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
		lspconfig.sumneko_lua.setup(opts)
	end,

	["jsonls"] = function()
		local jsonls_opts = require("plugin.config.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
		lspconfig.jsonls.setup(opts)
	end,

	["pyright"] = function()
		local py_opts = require("plugin.config.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", py_opts, opts)
		lspconfig.pyright.setup(opts)
	end,

	["tsserver"] = function()
		lspconfig.tsserver.setup(opts)
	end,

	["gopls"] = function()
		local go_opts = require("plugin.config.lsp.settings.gopls")
		opts = vim.tbl_deep_extend("force", go_opts, opts)
		lspconfig.gopls.setup(opts)
	end,
})
