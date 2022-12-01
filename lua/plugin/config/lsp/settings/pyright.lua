-- pyright.lua
-- settings for pyright LSP

return {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true
			},
		},
	},
}
