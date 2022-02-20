local status_ok, dap_go = pcall(require, "dap-go")
if not status_ok then
	vim.notify("Dap-go not not working.")
	return
end

dap_go.setup()
