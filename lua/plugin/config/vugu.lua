-- vugu.lua
--
-- File containing formatting for embedded Go code and enabling
-- of Go syntax highlighting in .vugu files
--
-- Syntax injection:
-- 	To add syntax highlighting of go to the embedded go in .vugu file,
-- 	simply add the query bellow to the file
-- 	~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/queries/html/injections.scm

-- parses the script element in .vugu file, which contains Go code. The last
-- capture raw_text @go is the Go code.
local embedded_go = vim.treesitter.parse_query(
	"html",
	[[
(script_element
  (start_tag
	(attribute) @_attr (#eq? @_attr "type=\"application/x-go\""))
  (raw_text) @go)
]]
)

-- finds the root of the file
local function find_root(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "html")
	local tree = parser:parse()[1]
	return tree:root()
end

-- runs goimports on the the code
local function run_formatter(code)
	-- XXX: golines fails when, with a nilpointer panic, when a long line is in
	-- 	the code string
	--[[ local command = "cat << EOF | golines --base-formatter='goimports -format-only'\n" ]]
	--[[ 	.. code ]]
	--[[ 	.. "\nEOF" ]]

	code = code:gsub("`", "\\`") -- escape ` in struct tags
	local command = "cat << EOF | goimports -format-only\n" .. code .. "\nEOF"
	local formatted = {}
	local job_id = vim.fn.jobstart(command, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			vim.list_extend(formatted, data)
		end,
	})

	vim.fn.jobwait({ job_id })
	table.remove(formatted) -- removes the last elements, which is only empty string
	return formatted
end

local function format_dat_go(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	if vim.bo[bufnr].filetype ~= "html" then
		vim.notify("can only be used in html/vugu files")
		return
	end

	local root = find_root(bufnr)
	local changes = {}
	for id, node in embedded_go:iter_captures(root, bufnr, 0, -1) do
		local name = embedded_go.captures[id]
		if name == "go" then
			-- { start row, start col, end row, end col }
			local range = { node:range() }

			local formatted =
				run_formatter(vim.treesitter.get_node_text(node, bufnr))

			table.insert(changes, 1, {
				start = range[1],
				final = range[3],
				formatted = formatted,
			})
		end
	end

	for _, change in ipairs(changes) do
		vim.api.nvim_buf_set_lines(
			bufnr,
			change.start,
			change.final,
			false,
			change.formatted
		)
	end
end

vim.api.nvim_create_user_command("VuguFormat", function()
	format_dat_go()
end, {})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("vugu-formatting", { clear = true }),
	pattern = "*.vugu",
	callback = function()
		format_dat_go()
	end,
})
