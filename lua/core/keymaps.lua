-- keymaps.lua
-- File for non-plugin remappings and keymap options.
--
-- Modes:
--   norma_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c"

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

---function for other plugins to register keybind
---
---@param mode string in which mode the action will execute
---@param key_map string button sequence/combination
---@param action string action which will be executed
function ADD_KEYMAP(mode, key_map, action)
	keymap(mode, key_map, action, opts)
end

---Function for mapping keybinds.
---Default options:
---		remap = true
--- 	silent = true
---
---@param mode string in which mode the cmd will execute
---@param keys string key sequence/combination
---@param cmd string command which will be executed
---@param options table|nil optional options
function Map(mode, keys, cmd, options)
	options = options or opts

	vim.keymap.set(mode, keys, cmd, options)
end

--Remap space as leader key
Map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ########## Normal ########## --

-- Switching between windows
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize +2<CR>")
Map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Navigate buffers
Map("n", "<A-l>", ":bnext<CR>")
Map("n", "<A-h>", ":bprevious<CR>")

-- Quicker save, I am lazy
Map("n", "<leader>w", ":w<CR>")

-- ########## Insert ########## --

-- Escape is too far away...
Map("i", "jj", "<ESC>")

-- ########## Visual ########## --

-- Stay in indent mode when indenting
Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
Map("v", "y", "myy`hay")
Map("v", "Y", "myY`y")

-- Does not yank after selecting and pasting
Map("x", "p", '"_dP')

-- ########## Visual Block ########## --

-- ########## Terminal ########## --

local term_opts = { silent = true }

-- Better terminal navigation
Map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
Map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
Map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
Map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
