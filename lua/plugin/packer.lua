-- plugins.lua
-- File for Packer plugin management

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer, close and reopen Neovim...")
	vim.cmd("packadd packer.nvim")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local packer = require("packer")

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

	use("windwp/nvim-autopairs") -- autopairs, closes pairs of (, [, {, ...

	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("JoosepAlviste/nvim-ts-context-commentstring") -- ext for Comment.vim

	use("kyazdani42/nvim-web-devicons") -- better icons

	-- Colorschemes
	-- use("lunarvim/darkplus.nvim")
	-- use("lunarvim/onedarker.nvim")
	use("akai54/2077.nvim")
	use("folke/tokyonight.nvim")

	-- CMP
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp") -- source for neovim's built-in lsp
	use("hrsh7th/cmp-nvim-lua") -- source for neovim's Lua api

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- NvimTree
	use("kyazdani42/nvim-tree.lua")

	-- Bufferline
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")

	-- Null-ls
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Lualine
	use("nvim-lualine/lualine.nvim")

	-- ToggleTerm
	use("akinsho/toggleterm.nvim")

	-- Project
	use("ahmedkhalf/project.nvim")

	-- Impatient
	use("lewis6991/impatient.nvim")

	-- Indent-blankline
	use("lukas-reineke/indent-blankline.nvim")

	-- Alpha
	use("goolord/alpha-nvim")

	-- Yabs => code runner
	use({
		"pianocomposer321/yabs.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use("ray-x/lsp_signature.nvim")

	use("dstein64/vim-startuptime")

	-- DAP
	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("nvim-telescope/telescope-dap.nvim")

	-- DAP for Go
	use("leoluz/nvim-dap-go")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
