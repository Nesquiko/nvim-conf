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

local augroup = vim.api.nvim_create_augroup("RustFormatting", {})
local function rust_on_attach(client, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end

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
		["rust_analyzer"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = rust_on_attach,
				settings = {
					inlayHints = {
						lifetimeElisionHints = { enable = "always" },
						genericParameterHints = { lifetime = { enable = true } },
					},
				},
			})
		end,
	},
})
