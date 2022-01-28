local colorscheme = "tokyonight"
--local colorscheme = "darkplus"

local status_ok, tokyonight = pcall(require, "tokyonight")
if status_ok then
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_italic_comments = false
    vim.g.tokyonight_italic_keywords = false
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
