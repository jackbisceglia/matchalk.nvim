local M = {}

local colors = {
	-- Base colors
	bg = "#273136",
	bg_darker = "#1c2427",
	fg = "#D1DED3",

	-- Terminal colors
	black = "#323E45",
	blue = "#7EA4B0",
	green = "#7eb08a",
	red = "#ff819f",
	yellow = "#d2b48c",
	purple = "#ba8eaf",

	-- Additional colors
	comment = "#7ea4b088",
	keyword = "#d2b48c",
	function_name = "#7eb08a",
	string = "#ba8eaf",
}

local function highlight(group, opts)
	local bg = opts.bg == nil and nil or opts.bg == "NONE" and "NONE" or opts.bg
	local fg = opts.fg == nil and nil or opts.fg == "NONE" and "NONE" or opts.fg
	local sp = opts.sp == nil and nil or opts.sp

	local style = opts.style or "NONE"

	vim.api.nvim_set_hl(0, group, {
		bg = bg,
		fg = fg,
		sp = sp,
		bold = style:find("bold") ~= nil,
		italic = style:find("italic") ~= nil,
		underline = style:find("underline") ~= nil,
	})
end

function M.setup()
	-- Editor
	highlight("Normal", { fg = colors.fg, bg = colors.bg })
	highlight("NormalFloat", { fg = colors.fg, bg = colors.bg_darker })
	highlight("SignColumn", { fg = colors.fg, bg = colors.bg })
	highlight("EndOfBuffer", { fg = colors.bg }) -- Hide ~ characters
	highlight("NormalNC", { fg = colors.fg, bg = colors.bg })
	highlight("Pmenu", { fg = colors.fg, bg = colors.bg_darker })
	highlight("PmenuSel", { fg = colors.bg_darker, bg = colors.green })
	highlight("PmenuSbar", { bg = colors.bg_darker })
	highlight("PmenuThumb", { bg = colors.fg })
	highlight("Cursor", { bg = colors.fg, fg = colors.bg })
	highlight("CursorLine", { bg = "#2C373C" })
	highlight("CursorLineNr", { fg = colors.fg, style = "bold" })
	highlight("LineNr", { fg = colors.comment })
	highlight("VertSplit", { fg = colors.black, bg = colors.bg })
	highlight("Visual", { bg = "#364046" })
	highlight("VisualNOS", { bg = "#364046" })
	highlight("Search", { fg = colors.bg, bg = colors.yellow })
	highlight("IncSearch", { fg = colors.bg, bg = colors.yellow })
	highlight("CurSearch", { fg = colors.bg, bg = colors.yellow })
	highlight("MatchParen", { fg = colors.yellow, style = "bold" })
	highlight("NonText", { fg = colors.comment })
	highlight("StatusLine", { fg = colors.fg, bg = colors.bg_darker })
	highlight("StatusLineNC", { fg = colors.comment, bg = colors.bg_darker })
	highlight("Folded", { fg = colors.comment, bg = colors.bg_darker })
	highlight("FoldColumn", { fg = colors.comment, bg = colors.bg })
	highlight("Title", { fg = colors.green, style = "bold" })

	-- Diagnostics
	highlight("Error", { fg = colors.red })
	highlight("ErrorMsg", { fg = colors.red })
	highlight("WarningMsg", { fg = colors.yellow })
	highlight("DiagnosticError", { fg = colors.red })
	highlight("DiagnosticWarn", { fg = colors.yellow })
	highlight("DiagnosticInfo", { fg = colors.blue })
	highlight("DiagnosticHint", { fg = colors.purple })
	highlight("DiagnosticUnderlineError", { sp = colors.red, style = "underline" })
	highlight("DiagnosticUnderlineWarn", { sp = colors.yellow, style = "underline" })
	highlight("DiagnosticUnderlineInfo", { sp = colors.blue, style = "underline" })
	highlight("DiagnosticUnderlineHint", { sp = colors.purple, style = "underline" })

	-- Common syntax
	highlight("Comment", { fg = colors.comment })
	highlight("String", { fg = colors.string })
	highlight("Keyword", { fg = colors.keyword, style = "bold" })
	highlight("Function", { fg = colors.function_name })
	highlight("Identifier", { fg = colors.fg })
	highlight("Constant", { fg = colors.purple })
	highlight("Special", { fg = colors.blue })
	highlight("Statement", { fg = colors.keyword, style = "bold" })
	highlight("PreProc", { fg = colors.keyword })
	highlight("Type", { fg = colors.green })
	highlight("Operator", { fg = colors.yellow })
	highlight("Todo", { fg = colors.yellow, bg = "NONE", style = "bold" })

	-- Diff
	highlight("DiffAdd", { fg = colors.green, bg = "#2A3734" })
	highlight("DiffChange", { fg = colors.yellow, bg = "#2A3531" })
	highlight("DiffDelete", { fg = colors.red, bg = "#2A2E34" })
	highlight("DiffText", { fg = colors.blue, bg = "#2A3139" })

	-- Git
	highlight("GitSignsAdd", { fg = colors.green })
	highlight("GitSignsChange", { fg = colors.yellow })
	highlight("GitSignsDelete", { fg = colors.red })

	-- LSP
	highlight("LspReferenceText", { bg = "#364046" })
	highlight("LspReferenceRead", { bg = "#364046" })
	highlight("LspReferenceWrite", { bg = "#364046" })

	-- Treesitter
	highlight("@variable", { fg = colors.fg })
	highlight("@function", { fg = colors.function_name })
	highlight("@function.call", { fg = colors.function_name })
	highlight("@keyword", { fg = colors.keyword, style = "bold" })
	highlight("@keyword.function", { fg = colors.keyword, style = "bold" })
	highlight("@keyword.operator", { fg = colors.yellow })
	highlight("@method", { fg = colors.function_name })
	highlight("@method.call", { fg = colors.function_name })
	highlight("@constructor", { fg = colors.function_name })
	highlight("@parameter", { fg = colors.fg })
	highlight("@string", { fg = colors.string })
	highlight("@number", { fg = colors.purple })
	highlight("@boolean", { fg = colors.purple })
	highlight("@field", { fg = colors.fg })
	highlight("@property", { fg = colors.fg })
	highlight("@comment", { fg = colors.comment })
	highlight("@type", { fg = colors.green })
	highlight("@constant", { fg = colors.purple })
	highlight("@operator", { fg = colors.yellow })
	highlight("@tag", { fg = colors.green })
	highlight("@tag.attribute", { fg = colors.function_name })
	highlight("@punctuation.bracket", { fg = colors.fg })
	highlight("@punctuation.delimiter", { fg = colors.fg })

	-- Terminal
	vim.g.terminal_color_0 = colors.black
	vim.g.terminal_color_1 = colors.red
	vim.g.terminal_color_2 = colors.green
	vim.g.terminal_color_3 = colors.yellow
	vim.g.terminal_color_4 = colors.blue
	vim.g.terminal_color_5 = colors.purple
	vim.g.terminal_color_6 = colors.blue
	vim.g.terminal_color_7 = colors.fg
	vim.g.terminal_color_8 = colors.comment
	vim.g.terminal_color_9 = colors.red
	vim.g.terminal_color_10 = colors.green
	vim.g.terminal_color_11 = colors.yellow
	vim.g.terminal_color_12 = colors.blue
	vim.g.terminal_color_13 = colors.purple
	vim.g.terminal_color_14 = colors.blue
	vim.g.terminal_color_15 = colors.fg
end

return M

