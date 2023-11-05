-- 改造之前的parse func，把文档变成{row，col}的形式，输入的是一个字符串
-- (1,1) index!!
local ut = require("jb_utils")
local flypy_table = require("flypy_simp")
local M = {}

local flypy = function(str)
	if flypy_table[str] ~= nil then
		return string.sub(flypy_table[str], 1, 2) -- 暂时只要双拼
	else
		return str
	end
end
local parse_line = function(str, line)
	local cum_l = 1
	local parsed = {}
	local tokens = {}
	for i = 1, ut.len(str) do
		tokens[i] = ut.sub(str, i, i)
	end
	for _, tok in ipairs(tokens) do
		local i = cum_l
		local t = flypy(tok)
		cum_l = cum_l + #tok
		table.insert(parsed, { row = line, col = i, t = t })
	end
	return parsed
end

local parse = function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local parsed = {}
	for i, line in ipairs(lines) do
		local parsed_line = parse_line(line, i)
		for _, tok in ipairs(parsed_line) do
			table.insert(parsed, tok)
		end
	end
	return parsed
end

local find_han = function()
	local str = vim.fn.input("")
	local parsed = parse()
	local found = {}
	for _, tok in ipairs(parsed) do
		if tok.t == str then
			found[#found + 1] = { pos = { tok.row, tok.col } }
		end
	end
	print(vim.inspect(found))
	return found
end

M.leap_zh = function()
	local winid = vim.api.nvim_get_current_win()
	require("leap").leap({
		target_windows = { winid },
		targets = find_han(),
	})
end
return M
