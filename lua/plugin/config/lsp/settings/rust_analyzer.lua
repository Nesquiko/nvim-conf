return {
	filetypes = { "rust" },
	root_dir = require("lspconfig.util").root_pattern("Cargo.toml"),
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
}
