local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions

local formatting_enabled = true
local function format()
	vim.lsp.buf.format({ async = false })
end

local function auto_format()
	if not formatting_enabled then
		return
	end
	format()
end

local function toggle_format_on_save()
	formatting_enabled = not formatting_enabled
end

vim.api.nvim_create_user_command("FormatToggle", toggle_format_on_save, {})

local opts = {
	sources = {
		formatting.stylua,
		formatting.prettier,
		formatting.gofumpt,
		formatting.goimports_reviser,
		formatting.golines,
		formatting.shfmt,
		formatting.forge_fmt,
	},
	on_attach = function(client, bufnr)
		if not client.supports_method("textDocument/formatting") then
			return
		end
		vim.api.nvim_clear_autocmds({
			group = augroup,
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = auto_format,
		})
	end,
	format = format,
}

null_ls.setup(opts)
