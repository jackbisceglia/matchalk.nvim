local M = {}

function M.setup()
	if vim.g.colors_name then
		vim.cmd("highlight clear")
	end

	vim.g.colors_name = "matchalk"
	vim.o.termguicolors = true

	require("matchalk.theme").setup()
end

return M

