local builtin = require("telescope.builtin")
local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
		preview = {
			filesize_limit = 0.1, -- MB
		},
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
		live_grep = {
			theme = "ivy",
		},
	},
})

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>vc", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Telescope find files in nvim config" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })

vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Telescope man pages" })
vim.keymap.set("n", "<leader>mp", builtin.man_pages, { desc = "Telescope man pages" })
vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "Telescope color scheme picker" })
vim.keymap.set("n", "<leader>ss", builtin.spell_suggest, { desc = "Telescope spelling suggestions" })
vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Telescope normal mode keymaps" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Telescope current buffer fuzzy finder" })
vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, { desc = "Telescope document symbols" })
