local status_ok, yabs = pcall(require, "yabs")
if not status_ok then
	return
end

local code_runner = _CODE_RUNNER

local config = {
	languages = {
		python = {
			tasks = {
				run = {
					command = "python3.10 %",
					output = code_runner,
				},
			},
		},

		toggleterm = {
			tasks = {
				run = {
					command = "",
					output = code_runner,
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
