local M = {}

function M.Normalize(p)
	if type(p) == "number" then
		return { top = p, right = p, bottom = p, left = p }
	end
	p = p or {}
	return {
		top = p.top or p[1] or 0,
		right = p.right or p[2] or 0,
		bottom = p.bottom or p[3] or 0,
		left = p.left or p[4] or 0,
	}
end

function M.Style(lines, pad, inner_width)
	lines = lines or {}
	inner_width = math.max(0, inner_width or 0)

	local out = {}

	-- top padding
	for _ = 1, pad.top do
		table.insert(out, string.rep(" ", inner_width))
	end

	-- content lines with left/right padding, truncated to inner_width
	local left = string.rep(" ", pad.left)
	local right = string.rep(" ", pad.right)
	local content_width = math.max(0, inner_width - pad.left - pad.right)

	for _, line in ipairs(lines) do
		line = tostring(line or "")
		if #line > content_width then
			line = line:sub(1, content_width)
		end
		line = line .. string.rep(" ", content_width - #line)
		table.insert(out, left .. line .. right)
	end

	-- bottom padding
	for _ = 1, pad.bottom do
		table.insert(out, string.rep(" ", inner_width))
	end

	return out
end

return M
