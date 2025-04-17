-- ~/.config/nvim/lua/theme.lua
-- matchalk for Neovim (alpha removed)

local M = {}

M.setup = function()
	-- enable true color
	vim.opt.termguicolors = true

	-- clear existing highlights
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end

	vim.g.colors_name = "matchalk"

	local c = {
		bg = "#273136",
		fg = "#D1DED3",
		red = "#ff819f",
		green = "#7eb08a",
		yellow = "#d2b48c",
		blue = "#7ea4b0",
		magenta = "#ba8eaf",
		cyan = "#7ea4b0",
		comment = "#7ea4b0",
		gutter_fg = "#D1DED3", -- was "#D1DED350"
		sel_bg = "#7eb08a", -- was "#7eb08a30"
		menu_bg = "#323e45",
	}

	local hl = vim.api.nvim_set_hl

	-- basic UI
	hl(0, "Normal", { fg = c.fg, bg = c.bg })
	hl(0, "CursorLine", { bg = c.menu_bg })
	hl(0, "CursorLineNr", { fg = c.yellow, bg = c.menu_bg, bold = true })
	hl(0, "LineNr", { fg = c.gutter_fg, bg = c.bg })
	hl(0, "Visual", { bg = c.sel_bg })
	hl(0, "Search", { fg = c.bg, bg = c.yellow })
	hl(0, "IncSearch", { fg = c.bg, bg = c.yellow })
	hl(0, "Pmenu", { fg = c.fg, bg = c.menu_bg })
	hl(0, "PmenuSel", { fg = c.bg, bg = c.yellow })
	hl(0, "PmenuSbar", { bg = c.bg })
	hl(0, "PmenuThumb", { bg = c.sel_bg })
	hl(0, "StatusLine", { fg = c.fg, bg = c.bg })
	hl(0, "StatusLineNC", { fg = c.gutter_fg, bg = c.bg })
	hl(0, "TabLine", { fg = "#cccccc", bg = "#1c2427" })
	hl(0, "TabLineSel", { fg = c.fg, bg = c.bg })
	hl(0, "TabLineFill", { fg = c.fg, bg = "#1c2427" })
	hl(0, "VertSplit", { fg = c.bg })

	-- syntax groups
	hl(0, "Comment", { fg = c.comment, italic = true })
	hl(0, "Constant", { fg = c.yellow })
	hl(0, "String", { fg = c.magenta })
	hl(0, "Character", { fg = c.magenta })
	hl(0, "Number", { fg = c.blue })
	hl(0, "Boolean", { fg = c.blue })
	hl(0, "Float", { fg = c.blue })
	hl(0, "Identifier", { fg = c.green })
	hl(0, "Function", { fg = c.green })
	hl(0, "Statement", { fg = c.yellow, bold = true })
	hl(0, "Conditional", { fg = c.yellow, bold = true })
	hl(0, "Repeat", { fg = c.yellow, bold = true })
	hl(0, "Label", { fg = c.yellow })
	hl(0, "Operator", { fg = c.yellow })
	hl(0, "Keyword", { fg = c.yellow, bold = true })
	hl(0, "Exception", { fg = c.yellow })
	hl(0, "PreProc", { fg = c.yellow })
	hl(0, "Include", { fg = c.yellow })
	hl(0, "Define", { fg = c.yellow })
	hl(0, "Macro", { fg = c.yellow })
	hl(0, "Type", { fg = c.blue })
	hl(0, "StorageClass", { fg = c.blue })
	hl(0, "Structure", { fg = c.blue })
	hl(0, "Typedef", { fg = c.blue })
	hl(0, "Special", { fg = c.magenta })
	hl(0, "SpecialChar", { fg = c.yellow })
	hl(0, "Tag", { fg = c.green })
	hl(0, "Delimiter", { fg = c.blue })
	hl(0, "Underlined", { fg = c.yellow, underline = true })
	hl(0, "Ignore", { fg = c.bg })
	hl(0, "Error", { fg = c.red })
	hl(0, "Todo", { fg = c.bg, bg = c.yellow })

	-- diagnostic (0.6+)
	hl(0, "DiagnosticError", { fg = c.red })
	hl(0, "DiagnosticWarn", { fg = c.yellow })
	hl(0, "DiagnosticInfo", { fg = c.yellow })
	hl(0, "DiagnosticHint", { fg = c.green })

	-- treesitter
	hl(0, "@comment", { fg = c.comment, italic = true })
	hl(0, "@constant", { fg = c.yellow })
	hl(0, "@string", { fg = c.magenta })
	hl(0, "@variable", { fg = c.fg })
	hl(0, "@function", { fg = c.green })
	hl(0, "@method", { fg = c.green })
	hl(0, "@keyword", { fg = c.yellow, bold = true })
	hl(0, "@type", { fg = c.blue })
	hl(0, "@parameter", { fg = c.red })
	hl(0, "@field", { fg = c.fg })
	hl(0, "@property", { fg = c.fg })
	hl(0, "@tag", { fg = c.yellow })
	hl(0, "@punctuation", { fg = c.blue })
end

return M
