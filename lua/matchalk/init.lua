-- lua/matchalk/init.lua
-- 1:1 VSCode→Neovim port of matchalk.json, alpha intact via blend.

local M = {}

-- parse "#RRGGBB" or "#RRGGBBAA" → { hex="#RRGGBB", blend=0–100 }
local function parse_color(col)
	if not col or col:sub(1, 1) ~= "#" then
		return {}
	end
	local hex = col:sub(1, 7)
	local blend
	if #col == 9 then
		blend = math.floor((tonumber(col:sub(8, 9), 16) / 255) * 100 + 0.5)
	end
	return { hex = hex, blend = blend }
end

-- map some common VSCode color keys → Neovim highlight groups
-- extend this to cover all the UI pieces you need
local ui_map = {
	["editor.background"] = "Normal",
	["editor.foreground"] = "Normal",
	["editor.selectionBackground"] = "Visual",
	["editor.lineHighlightBackground"] = "CursorLine",
	["editor.findMatchBorder"] = "Search",
	["editor.findMatchHighlightBackground"] = "IncSearch",
	["editorGutter.addedBackground"] = "DiffAdd",
	["editorGutter.modifiedBackground"] = "DiffChange",
	["editorGutter.deletedBackground"] = "DiffDelete",
	["statusBar.background"] = "StatusLine",
	["statusBar.foreground"] = "StatusLine",
	["statusBar.noFolderBackground"] = "StatusLineNC",
	["sideBar.background"] = "NormalFloat",
	["editorBracketMatch.background"] = "MatchParen",
	-- …add more as you go…
}

-- map simplistic scope → Treesitter group; extend as needed
local tok_map = {
	comment = "@comment",
	string = "@string",
	keyword = "@keyword",
	variable = "@variable",
	["entity.name.function"] = "@function",
	constant = "@constant",
	punctuation = "@punctuation",
}

local function map_scope(scope)
	for pat, ts in pairs(tok_map) do
		if scope:find(pat, 1, true) then
			return ts
		end
	end
end

function M.setup()
	-- enable true color                         .
	vim.opt.termguicolors = true
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end

	-- mark ourselves loaded
	vim.g.colors_name = "matchalk"

	-- locate matchalk.json in this plugin’s folder
	local src = debug.getinfo(1, "S").source:sub(2)
	local plugin_root = src:match("(.*)/lua/matchalk/init.lua$")
	local json_path = plugin_root .. "/lua/matchalk/matchalk.json"

	-- read & decode
	local data = vim.fn.readfile(json_path)
	local raw = vim.fn.json_decode(table.concat(data, "\n"))

	local set_hl = vim.api.nvim_set_hl

	-- 1) UI colors
	for key, col in pairs(raw.colors) do
		local group = ui_map[key]
		if group then
			local p = parse_color(col)
			set_hl(0, group, {
				fg = p.hex,
				bg = p.hex,
				blend = p.blend,
			})
		end
	end

	-- 2) tokenColors → treesitter/syntax
	for _, entry in ipairs(raw.tokenColors) do
		local fg = entry.settings.foreground
		if fg then
			local p = parse_color(fg)
			local style = entry.settings.fontStyle or ""
			for _, scope in ipairs(type(entry.scope) == "table" and entry.scope or { entry.scope }) do
				local ts = map_scope(scope)
				if ts then
					set_hl(0, ts, {
						fg = p.hex,
						blend = p.blend,
						bold = style:find("bold") and true or nil,
						italic = style:find("italic") and true or nil,
					})
				end
			end
		end
	end
end

return M
