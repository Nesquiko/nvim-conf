require("setup.debugger.nvim-dap-ui")

require("nvim-dap-virtual-text").setup()

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

require("setup.debugger.nvim-dap-go")

-- DAP
-- keymap("n", "<F22>", ":lua require('dap').continue()<CR>", opts)
-- keymap("n", "<F23>", ":lua require('dap').terminate()<CR>", opts)
-- keymap("n", "<c-b>", ":lua require('dap').toggle_breakpoint()<CR>", opts)
-- keymap("n", "<F5>", ":lua require('dap').step_into()<CR>", opts)
-- keymap("n", "<F17>", ":lua require('dap').step_out()<CR>", opts)
-- keymap("n", "<F6>", ":lua require('dap').step_over()<CR>", opts)
-- keymap("n", "<F4>", ":lua require('dap').repl.open()<CR>", opts)
