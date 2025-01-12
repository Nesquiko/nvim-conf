local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local fidget = require("fidget")

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions

local formatting_enabled = true
local function format()
	vim.lsp.buf.format({
		async = false,
		filter = function(client)
			return client.name ~= "ts_ls" and client.name ~= "solidity_ls_nomicfoundation"
		end,
	})
end

local function auto_format()
	if not formatting_enabled then
		fidget.notify("Formatting is disabled", vim.log.levels.WARN, { key = "formatting_toggle" })
		return
	end
	format()
end

local function toggle_format_on_save()
	formatting_enabled = not formatting_enabled
	fidget.notify(
		"Formatting " .. (formatting_enabled and "enabled" or "disabled"),
		vim.log.levels.INFO,
		{ key = "formatting_toggle" }
	)
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
		formatting.black,
		formatting.pg_format.with({ extra_args = { "-u", 1, "-U", 1, "-f", 1, "--no-space-function" } }),
		formatting.mix,
	},
	on_attach = function(client, bufnr)
		if not client.supports_method("textDocument/formatting") then
			return
		end
		vim.keymap.set("n", "<leader>l", auto_format, { buffer = bufnr, desc = "Formats current buffer" })
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
