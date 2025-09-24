return {
	"augmentcode/augment.vim",
	lazy = false, -- load at startup
	priority = 1000,
	init = function()
		vim.g.augment_disable_completions = true
		vim.g.augment_workspace_folders = {
			-- vim.fn.expand("~/work/dpd/dmk20"),
			vim.fn.expand("~/prog/swim-journal"),
		}
	end,
}
