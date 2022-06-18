-- init.lua
-- Main config file for nvim. Every initialization is called with in a pcall,
-- so if one plugin fails, nvim is still loaded. When an error occurs, a log
-- file is created in ./log dir.

require("core.log")
local data = vim.fn.stdpath("data")
local file_name = data .. "/log/" .. Get_date_time() .. ".log"
local file = io.open(file_name, "a")
local wasError = false

local ok, err = pcall(require, "setup.keymaps")
if not ok and file then
	wasError = true
	file:write("setup.keymaps:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.options")
if not ok and file then
	wasError = true
	file:write("setup.options:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.plugins")
if not ok and file then
	wasError = true
	file:write("setup.plugins:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.colorscheme")
if not ok and file then
	wasError = true
	file:write("setup.colorscheme:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.cmp")
if not ok and file then
	wasError = true
	file:write("setup.cmp:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.lsp")
if not ok and file then
	wasError = true
	file:write("setup.lsp:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.telescope")
if not ok and file then
	wasError = true
	file:write("setup.telescope:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.treesitter")
if not ok and file then
	wasError = true
	file:write("setup.treesitter:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.autopairs")
if not ok and file then
	wasError = true
	file:write("setup.autopairs:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.comment")
if not ok and file then
	wasError = true
	file:write("setup.comment:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.gitsigns")
if not ok and file then
	wasError = true
	file:write("setup.gitsigns:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.nvim-tree")
if not ok and file then
	wasError = true
	file:write("setup.nvim-tree:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.bufferline")
if not ok and file then
	wasError = true
	file:write("setup.bufferline:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.toggleterm")
if not ok and file then
	wasError = true
	file:write("setup.toggleterm:\n" .. err .. "\n")
end

ok, err = pcall(require, "setup.lualine")
if not ok and file then
	wasError = true
	file:write("setup.lualine:\n" .. err .. "\n")
end

require("setup.project")
require("setup.impatient")
require("setup.indent-blankline")
require("setup.alpha")
require("setup.surround")
require("setup.yabs")
require("setup.debugger")

file:close()
if wasError then
	vim.notify("An error occured, see logs in " .. data .. "/log for error info")
else
	os.remove(file_name)
end
