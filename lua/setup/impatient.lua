-- impatient.lua
-- Config file for lewis6991/impatient.nvim
--
-- Defualt configuration is used. Chunk cache and
-- module resolution cache are both turned on. The
-- cache files are in ~/.cache/nvim/

_G.__luacache_config = {
	chunks = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_chunks",
	},
	modpaths = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
	},
}
local impatient = require("impatient")
impatient.enable_profile()
