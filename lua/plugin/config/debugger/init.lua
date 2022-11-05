-- init.lua
--
-- Main configuration file for nvim-dap plugin, used
-- to launch debugger.

require("dap")

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

Map("n", "<C-b>", ":lua require('dap').toggle_breakpoint()<CR>")
Map(
	"n",
	"<leader>b",
	":lua require('dap').toggle_breakpoint(vim.fn.input('Breakpoint Condition: '), nil, nil, true)<CR>"
)
Map("n", "<F5>", ":lua require('dap').continue()<CR>")
Map("n", "<F29>", ":lua require('dap').terminate()<CR>")
Map("n", "<F6>", ":lua require('dap').step_into()<CR>")
Map("n", "<F30>", ":lua require('dap').step_out()<CR>")
Map("n", "<F7>", ":lua require('dap').step_over()<CR>")

Map("n", "<F4>", ":lua require('dap').repl.open()<CR>")
Map("n", "<F28>", ":lua require('dap').repl.close()<CR>")

require("plugin.config.debugger.dap-events")
require("plugin.config.debugger.nvim-dap-go")
require("plugin.config.debugger.nvim-dap-python")
require("plugin.config.debugger.virtual-text")
require("plugin.config.debugger.telescope-ext")
require("plugin.config.debugger.nvim-dap-ui")
