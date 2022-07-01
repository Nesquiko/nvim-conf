-- init.lua
-- Main init file for lsp config.

require("lspconfig")
require("plugin.config.lsp.lsp-installer")
require("plugin.config.lsp.handlers").setup()
require("plugin.config.lsp.null-ls")
require("plugin.config.lsp.signature")
