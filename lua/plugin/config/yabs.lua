-- yabs.lua
-- Config file for pianocomposer321/yabs.nvim
--
-- CURRENTLY_SUPPORTED_LANGS:
-- 	- Python
-- 	- Golang
--
-- Display tasks in Telescope with ALT + t
local yabs = require("yabs")
ADD_KEYMAP("n", "<A-t>", "<cmd>Telescope yabs tasks<CR>")
ADD_KEYMAP("n", "<F10>", ":lua require('yabs'):run_task('run')<CR>")
ADD_KEYMAP("n", "<F9>", ":lua require('yabs'):run_task('build')<CR>")

local config = {
	languages = {
		python = {
			tasks = {
				run = {
					command = "python3.10 %",
					output = _CODE_RUNNER,
				},
			},
		},

		go = {
			tasks = {
				run = {
					command = "go run .",
					output = _CODE_RUNNER,
				},
				build = {
					command = "go build .",
					output = _CODE_RUNNER,
				},
			},
		},

		javascript = {
			tasks = {
				run = {
					command = "bun run %",
					output = _CODE_RUNNER,
				},
				build = {
					command = "echo No building settings specified.",
					output = "echo",
				},
			},
		},

		sh = {
			tasks = {
				run = {
					command = "sh %",
					output = _CODE_RUNNER,
				},
			},
		},
	},

	-- Not configured filetypes default to this
	tasks = {
		build = {
			command = "echo No building settings specified.",
			output = "echo",
		},
		run = {
			command = "echo No running settings specified.",
			output = "echo",
		},
	},
}

yabs:setup(config)
