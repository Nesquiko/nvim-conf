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
local term_opts = { silent = true }

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
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)

-- Quicker save, I am lazy
keymap("n", "<leader>w", ":w<CR>", opts)

-- ########## Insert ########## --

-- Escape is too far away...
keymap("i", "jj", "<ESC>", opts)

-- ########## Visual ########## --

-- Stay in indent mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap("v", "y", "myy`hay", opts)
keymap("v", "Y", "myY`y", opts)

-- Does not yank after selecting and pasting
keymap("x", "p", '"_dP', opts)
--[[ keymap("x", "<leader>p", '"_dP', opts) ]]

-- ########## Visual Block ########## --

-- ########## Terminal ########## --

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
