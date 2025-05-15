require("fidget").setup({})
require("mason").setup()

local to_install = {
	-- LSPs
	"lua_ls",
	"gopls",
	"rust_analyzer",
	"tailwindcss",
	"ts_ls",
	"bashls",
	"marksman",
	"solidity_ls_nomicfoundation",

	-- Formaters
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
		["gopls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.gopls.setup({
				capabilities = vim.tbl_deep_extend("force", { documentFormattingProvider = false }, capabilities),
				settings = {
					gopls = {
						buildFlags = { "-tags=integration,e2e" },
					},
				},
			})
		end,
		["ts_ls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = vim.tbl_deep_extend("force", { documentFormattingProvider = false }, capabilities),
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
			})
		end,
		["denols"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.denols.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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
						workspace = {
							-- Make the server aware of Neovim runtime files, inspired by https://www.reddit.com/r/neovim/comments/x3bd4i/how_can_i_get_lsp_to_recognize_builtin_neovim_api/
							library = vim.api.nvim_get_runtime_file("lua", true),
						},
					},
				},
			})
		end,
		["rust_analyzer"] = function()
			local lspconfig = require("lspconfig")

			local cargoConfig = ".cargo/config.toml"
			local settings = {
				inlayHints = {
					lifetimeElisionHints = { enable = "always" },
					genericParameterHints = { lifetime = { enable = true } },
				},
			}

			local exists = vim.loop.fs_stat(cargoConfig)
			if exists then
				for line in io.lines(cargoConfig) do
					local target = line:match('^%s*target%s*=%s*"([^"]+)"')
					if target then
						settings["cargo"] = { target = target, allTargets = false }
						settings["check"] = { allTargets = false }
						break
					end
				end
			end

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = rust_on_attach,
				settings = settings,
			})
		end,
	},
})
