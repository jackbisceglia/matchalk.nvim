-- ~/.config/nvim/lua/theme.lua
--
-- “matchalk” port that actually honors the original alpha values
--

local M = {}

-- parse "#RRGGBB" or "#RRGGBBAA" into {r,g,b,a}
local function hex2rgba(hex)
	hex = hex:gsub("#", "")
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)
	local a = 255
	if #hex == 8 then
		a = tonumber(hex:sub(7, 8), 16)
	end
	return { r, g, b, a }
end

-- blend fg over bg, alpha ∈ [0..255], returns "#RRGGBB"
local function blend(fg_hx, bg_hx)
	local fg = hex2rgba(fg_hx)
	local bg = hex2rgba(bg_hx)
	local a = fg[4] / 255
	local r = math.floor(fg[1] * a + bg[1] * (1 - a) + 0.5)
	local g = math.floor(fg[2] * a + bg[2] * (1 - a) + 0.5)
	local b = math.floor(fg[3] * a + bg[3] * (1 - a) + 0.5)
	return string.format("#%02x%02x%02x", r, g, b)
end

function M.setup()
	vim.opt.termguicolors = true
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "matchalk"

	-- your original VSCode palette with alpha
	local raw = {
		bg = "#273136",
		fg = "#D1DED3",
		red = "#ff819f",
		green = "#7eb08a",
		yellow = "#d2b48c",
		blue = "#7ea4b0",
		magenta = "#ba8eaf",
		comment = "#7ea4b088",
		gutter = "#D1DED350",
		sel = "#7eb08a30",
		menu = "#323e45",
	}

	-- pre‑blend any 8‑digit colors over bg
	local c = {}
	for k, v in pairs(raw) do
		c[k] = (#v == 9) and blend(v, raw.bg) or v
	end

	local hl = vim.api.nvim_set_hl

	-- core UI groups
	hl(0, "Normal", { fg = c.fg, bg = c.bg })
	hl(0, "CursorLine", { bg = c.menu })
	hl(0, "CursorLineNr", { fg = c.yellow, bg = c.menu, bold = true })
	hl(0, "LineNr", { fg = c.gutter, bg = c.bg })
	hl(0, "Visual", { bg = c.sel })
	hl(0, "Search", { fg = c.bg, bg = c.yellow })
	hl(0, "IncSearch", { fg = c.bg, bg = c.yellow })
	hl(0, "Pmenu", { fg = c.fg, bg = c.menu })
	hl(0, "PmenuSel", { fg = c.bg, bg = c.yellow })
	hl(0, "PmenuSbar", { bg = c.bg })
	hl(0, "PmenuThumb", { bg = c.sel })
	hl(0, "StatusLine", { fg = c.fg, bg = c.bg })
	hl(0, "StatusLineNC", { fg = c.gutter, bg = c.bg })
	hl(0, "TabLine", { fg = "#cccccc", bg = "#1c2427" })
	hl(0, "TabLineSel", { fg = c.fg, bg = c.bg })
	hl(0, "TabLineFill", { fg = c.fg, bg = "#1c2427" })
	hl(0, "VertSplit", { fg = c.bg })

	-- syntax
	hl(0, "Comment", { fg = c.comment, italic = true })
	hl(0, "Constant", { fg = c.yellow })
	hl(0, "String", { fg = c.magenta })
	hl(0, "Number", { fg = c.blue })
	hl(0, "Identifier", { fg = c.green })
	hl(0, "Function", { fg = c.green })
	hl(0, "Statement", { fg = c.yellow, bold = true })
	hl(0, "Keyword", { fg = c.yellow, bold = true })
	hl(0, "Operator", { fg = c.yellow })
	hl(0, "Type", { fg = c.blue })
	hl(0, "Error", { fg = c.red })
	hl(0, "Todo", { fg = c.bg, bg = c.yellow })

	-- diagnostics
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
	hl(0, "@keyword", { fg = c.yellow, bold = true })
	hl(0, "@type", { fg = c.blue })
end

return M
