-- init.lua
--
-- Main configuration file for nvim-dap plugin, used
-- to launch debugger.

require("dap")

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

ADD_KEYMAP("n", "<C-b>", ":lua require('dap').toggle_breakpoint()<CR>")
ADD_KEYMAP(
	"n",
	"<leader>b",
	":lua require('dap').toggle_breakpoint(vim.fn.input('Breakpoint Condition: '), nil, nil, true)<CR>"
)
ADD_KEYMAP("n", "<F5>", ":lua require('dap').continue()<CR>")
ADD_KEYMAP("n", "<F29>", ":lua require('dap').terminate()<CR>")
ADD_KEYMAP("n", "<F6>", ":lua require('dap').step_into()<CR>")
ADD_KEYMAP("n", "<F30>", ":lua require('dap').step_out()<CR>")
ADD_KEYMAP("n", "<F7>", ":lua require('dap').step_over()<CR>")

ADD_KEYMAP("n", "<F4>", ":lua require('dap').repl.open()<CR>")
ADD_KEYMAP("n", "<F28>", ":lua require('dap').repl.close()<CR>")

require("plugin.config.debugger.dap-events")
require("plugin.config.debugger.nvim-dap-go")
require("plugin.config.debugger.nvim-dap-python")
require("plugin.config.debugger.virtual-text")
require("plugin.config.debugger.telescope-ext")
require("plugin.config.debugger.nvim-dap-ui")
