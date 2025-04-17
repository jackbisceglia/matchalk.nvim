-- lua/matchalk/init.lua
-- 1:1 port of matchalk.json, zero build, proper fg/bg handling

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

-- for each VSCode color key, which highlight group
-- to set, and which attribute (fg/bg) to use
local ui_map_attrs = {
	["editor.background"] = { group = "Normal", bg = true },
	["editor.foreground"] = { group = "Normal", fg = true },
	["editor.selectionBackground"] = { group = "Visual", bg = true },
	["editor.lineHighlightBackground"] = { group = "CursorLine", bg = true },
	["editor.findMatchBorder"] = { group = "Search", fg = true },
	["editor.findMatchHighlightBackground"] = { group = "Search", bg = true },
	["editorGutter.addedBackground"] = { group = "DiffAdd", bg = true },
	["editorGutter.modifiedBackground"] = { group = "DiffChange", bg = true },
	["editorGutter.deletedBackground"] = { group = "DiffDelete", bg = true },
	["statusBar.background"] = { group = "StatusLine", bg = true },
	["statusBar.foreground"] = { group = "StatusLine", fg = true },
	["statusBar.noFolderBackground"] = { group = "StatusLineNC", bg = true },
	["sideBar.background"] = { group = "NormalFloat", bg = true },
	["sideBar.foreground"] = { group = "NormalFloat", fg = true },
	["editorBracketMatch.background"] = { group = "MatchParen", bg = true },
	-- …add more mappings here as you discover groups you care about…
}

-- a minimal scope→treesitter map; you can expand this too
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
	vim.opt.termguicolors = true
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "matchalk"

	-- locate our bundled JSON
	local src = debug.getinfo(1, "S").source:sub(2)
	local root = src:match("(.*)/lua/matchalk/init.lua$")
	local json = table.concat(vim.fn.readfile(root .. "/lua/matchalk/matchalk.json"), "\n")
	local raw = vim.fn.json_decode(json)

	local set_hl = vim.api.nvim_set_hl

	-- 1) UI colours
	for key, col in pairs(raw.colors) do
		local m = ui_map_attrs[key]
		if m then
			local p = parse_color(col)
			local args = {}
			if m.fg then
				args.fg = p.hex
				if p.blend then
					args.blend = p.blend
				end
			end
			if m.bg then
				args.bg = p.hex
				if p.blend then
					args.blend = p.blend
				end
			end
			set_hl(0, m.group, args)
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
