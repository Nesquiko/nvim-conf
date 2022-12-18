-- mason.lua
--
-- Configuration for mason plugin, which is a improved replacement for
-- Lsp-installer.

require("mason").setup()

local servers = {
	"sumneko_lua",
	"jsonls",
	"pyright",
	"gopls",
	"tsserver",
	"marksman",
	"rust_analyzer",
	"solidity",
}

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

local opts = {
	on_attach = require("plugin.config.lsp.handlers").on_attach,
	capabilities = require("plugin.config.lsp.handlers").capabilities,
}

local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup(opts)
lspconfig.marksman.setup(opts)
lspconfig.solidity.setup(opts)
lspconfig.tsserver.setup(opts)

local sumneko_opts = require("plugin.config.lsp.settings.sumneko_lua")
opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
lspconfig.sumneko_lua.setup(opts)

local jsonls_opts = require("plugin.config.lsp.settings.jsonls")
opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
lspconfig.jsonls.setup(opts)

local py_opts = require("plugin.config.lsp.settings.pyright")
opts = vim.tbl_deep_extend("force", py_opts, opts)
lspconfig.pyright.setup(opts)

local go_opts = require("plugin.config.lsp.settings.gopls")
opts = vim.tbl_deep_extend("force", go_opts, opts)
lspconfig.gopls.setup(opts)
