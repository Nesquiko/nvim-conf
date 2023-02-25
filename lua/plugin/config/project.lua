-- project.lua
-- Config file for ahmedkhalf/project.nvim
--
-- PATTERN_MATCHING:
-- 	@see https://github.com/ahmedkhalf/project.nvim#pattern-matching
--
-- TELESCOPE:
-- 	set as a extenstion for telescope.
-- 	LEADER + p => opens projects in telescope
-- 	for keymappings in telescope
-- 		@see https://github.com/ahmedkhalf/project.nvim#telescope-mappings
-- 	Also Telescope projects command is used in Alpha (@see alpha.lua)
--

local project = require("project_nvim")

project.setup({
	---@usage set to false to disable project.nvim.
	--- This is on by default since it's currently the expected behavior.
	active = true,
	---@usage set to true to disable setting the current-woriking directory
	--- Manual mode doesn't automatically change your root directory, so you have
	--- the option to manually do so using `:ProjectRoot` command.
	manual_mode = false,
	---@usage Methods of detecting the root directory
	--- Allowed values: **"lsp"** uses the native neovim lsp
	--- **"pattern"** uses vim-rooter like glob pattern matching. Here
	--- order matters: if one is not detected, the other is used as fallback. You
	--- can also delete or rearangne the detection methods.
	-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
	detection_methods = { "lsp", "pattern" },
	---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
	patterns = {
		"gradlew",
		".git",
		"_darcs",
		".hg",
		".bzr",
		".svn",
		"Makefile",
		"package.json",
		"go.mod",
	},
	---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
	ignore_lsp = { "null-ls", "jsonls" },
	-- Don't calculate root dir on specific directories
	exclude_dir = {},
	---@ Show hidden files in telescope when searching for files in a project
	show_hidden = false,
	---@usage When set to false, you will get a message when project.nvim changes your directory.
	-- When set to false, you will get a message when project.nvim changes your directory.
	silent_chdir = false,
	---@type string
	---@usage path to store the project history for use in telescope
	datapath = vim.fn.stdpath("data"),
})

local telescope = require("telescope")
telescope.load_extension("projects")
Map("n", "<leader>p", "<cmd>Telescope projects<CR>")
