-- null-ls.lua
-- Config file for jose-elias-alvarez/null-ls.nvim
--
-- PYTHON:
-- 	- black for formatting
-- 	- flake8 for diagnostics
--
-- GOLANG:
-- 	- golines for formatting (also it runs goimports)
-- 	- golangci_lint for formatting
--
-- LUA:
-- 	- stylua for formatting

local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	diagnostics_format = "[#{c}] #{m} (#{s})",
	sources = {
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.golines,

		diagnostics.flake8.with({ extra_args = { "--max-line-length", "88" } }),
		diagnostics.golangci_lint,
	},
})
