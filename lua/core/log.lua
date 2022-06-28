local M = {}
local Logger = { was_error = false }

local function date_time()
	local date_table = os.date("*t")
	local ms = string.match(tostring(os.clock()), "%d%.(%d+)")
	local hour, minute, second = date_table.hour, date_table.min, date_table.sec
	local year, month, day = date_table.year, date_table.month, date_table.day -- date_table.wday to date_table.day
	local result = string.format("%d-%d-%d_%d:%d:%d:%s", year, month, day, hour, minute, second, ms)

	return result
end

function M.init()
	local log_path = vim.fn.stdpath("cache") .. "/plugin_log/"
	local file_name = log_path .. date_time() .. ".log"
	Logger.file_name = file_name
	Logger.file = io.open(file_name, "a")

	return Logger
end

function Logger:error(origin, err)
	self.file:write(origin .. ":\n\t" .. err .. "\n")
	self.was_error = true
end

function Logger:cleanup()
	self.file:close()
	if self.wasError then
		vim.notify("An error occured, see logs for details")
	else
		os.remove(self.file_name)
	end
end

return M
