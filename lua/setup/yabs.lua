local status_ok, yabs = pcall(require, "yabs")
if not status_ok then
	return
end

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

		toggleterm = {
			tasks = {
				run = {
					command = "",
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
