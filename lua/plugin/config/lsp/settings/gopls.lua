-- gopls.lua
-- settings for gopls LSP

return {
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			buildFlags = { "-tags=unit" },
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}
