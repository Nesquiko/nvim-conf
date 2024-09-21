require("fidget").setup({})
require("mason").setup()

local to_install = {
	-- LSPs
	"lua_ls",
	"gopls",
	"rust_analyzer",
	"eslint",
	"tailwindcss",
	"ts_ls",
	"bashls",
	"marksman",
	"solidity_ls_nomicfoundation",

	-- -- Formaters
	"stylua",
	"prettier",
	"gofumpt",
	"goimports-reviser",
	"golines",
	"shfmt",

	-- Linters
	"staticcheck",
	"shellcheck",
}

local cmp_lsp = require("cmp_nvim_lsp")
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

require("mason-tool-installer").setup({ ensure_installed = to_install })

require("mason-lspconfig").setup({
	handlers = {
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end,
		["ts_ls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = vim.tbl_deep_extend("force", { documentFormattingProvider = false }, capabilities),
			})
		end,
		["lua_ls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "Lua 5.1" },
						diagnostics = {
							globals = { "bit", "vim" },
						},
					},
				},
			})
		end,
	},
})
