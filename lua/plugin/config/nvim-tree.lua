-- nvim-tree.lua
-- Config file for kyazdani42/nvim-tree.lua.
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local nvim_tree = require("nvim-tree")
local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")
-- @deprecated
--[[ local nvim_tree_config = require("nvim-tree.config") ]]
--[[ local tree_cb = nvim_tree_config.nvim_tree_callback ]]
Map("n", "<leader>e", ":NvimTreeToggle<cr>")

local function edit_or_open()
	-- open as vsplit on current node
	local action = "edit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
		view.close() -- Close the tree if file was opened
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.node.open-file").fn(
			action,
			node.absolute_path
		)
		view.close() -- Close the tree if file was opened
	end
end

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	-- Mappings migrated from view.mappings.list
	-- You will need to insert "your code goes here" for any mappings with a custom action_cb
	vim.keymap.set("n", "l", edit_or_open, opts("Open"))
end

nvim_tree.setup({
	on_attach = on_attach,
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		width = 30,
		--[[ height = 30, ]]
		hide_root_folder = false,
		side = "left",
		-- @deprecated
		--[[ mappings = { ]]
		--[[ 	custom_only = false, ]]
		--[[ 	list = { ]]
		--[[ 		{ ]]
		--[[ 			key = "l", ]]
		--[[ 			action = "edit", ]]
		--[[ 			action_cb = edit_or_open, ]]
		--[[ 		}, ]]
		--[[ 		{ key = "h", cb = tree_cb("close_node") }, ]]
		--[[ 		{ key = "v", cb = tree_cb("vsplit") }, ]]
		--[[ 	}, ]]
		--[[ }, ]]
		number = false,
		relativenumber = false,
	},
	renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_git = false,
		highlight_opened_files = "all", -- none, icon, name, all
		root_folder_modifier = ":t",
		indent_markers = {
			enable = false,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
})
