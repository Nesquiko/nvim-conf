local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })

vim.keymap.set("n", "<leader>mp", builtin.man_pages, { desc = "Telescope man pages" })
vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "Telescope color scheme picker" })
vim.keymap.set("n", "<leader>ss", builtin.spell_suggest, { desc = "Telescope spelling suggestions" })
vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Telescope normal mode keymaps" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Telescope current buffer fuzzy finder" })
vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, { desc = "Telescope document symbols" })
