Utils = {}

---@param text string
---@param offset number
---@return number, number
function Utils:offset_to_row_column(text, offset)
	local row, column, position = 0, 0, 0

	for line in text:gmatch("([^\n]*)\n?") do
		if offset <= position + #line then
			column = offset - position
			return row, column
		end
		position = position + #line + 1 -- add 1 to skip the newline
		row = row + 1
	end

	return row, column
end
