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
--
-- JS:
-- 	- prettier for formatting
-- 	- standardjs for diagnostics

local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	diagnostics_format = "[#{c}] #{m} (#{s})",
	sources = {
		formatting.stylua,

		formatting.black.with({ extra_args = { "--fast" } }),
		diagnostics.flake8.with({
			extra_args = {
				"--max-line-length",
				"88",
				"--extend-ignore",
				"E203",
			},
		}),

		formatting.prettier.with({
			extra_filetypes = { "toml", "solidity" },
			extra_args = {
				"--no-semi",
				"--single-quote",
				"--trailing-comma",
				"none",
				"--use-tabs true",
			},
		}),

		diagnostics.golangci_lint,
		diagnostics.staticcheck,
		formatting.golines,
	},
})
