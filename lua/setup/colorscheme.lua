-- colorscheme.lua
-- File for configuring neovim colortheme.

-- local colorscheme = "tokyonight"
local colorscheme = "2077"

if colorscheme == "tokyonight" then
	-- tokyonight specific settings
	-- MUST be called before setting colorscheme with vim cmd!
	local ok, _ = pcall(require, "tokyonight")
	if ok then
		vim.g.tokyonight_style = "night"
		vim.g.tokyonight_italic_comments = false
		vim.g.tokyonight_italic_keywords = false
		vim.g.tokyonight_italic_functions = false
		vim.g.tokyonight_italic_variables = false
	end
end

-- tries to set colorscheme with vim cmd
vim.cmd("colorscheme " .. colorscheme)
