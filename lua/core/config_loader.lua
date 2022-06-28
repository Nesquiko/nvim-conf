local M = {}

local logger = require("core.log").init()

function M:load_configs(configs)
	for _, conf in ipairs(configs) do
		local ok, err = pcall(require, conf)
		if not ok then
			logger:error(conf, err)
		end
	end

	logger:cleanup()
end

return M
