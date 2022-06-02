-- init.lua
-- Main init file for lsp config.

require("lspconfig")
require("setup.lsp.lsp-installer")
require("setup.lsp.handlers").setup()
require("setup.lsp.null-ls")
