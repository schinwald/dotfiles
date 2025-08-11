---Gets the current folder
vim.fn.where_am_i = function()
	local path = vim.fn.expand("%:p")
	return string.sub(vim.system({ "dirname", path }, { text = true }):wait().stdout, 1, -2)
end

---Sets the environment variable for the default git
vim.fn.use_default_git = function()
	-- If no git repository is found then default to the dotfile one
	local where_am_i = vim.fn.where_am_i()
	if vim.uv.fs_stat(where_am_i) then
		local code = vim.system({ "git", "status" }, { cwd = where_am_i }):wait().code
		if code ~= 0 then
			vim.env.GIT_DIR = vim.env.DOTFILES
			vim.env.GIT_WORK_TREE = vim.env.HOME
		end
	end
end

---Get the parent node of the given type
---@param node TSNode | nil
---@param type string
---@return TSNode | nil
vim.fn.get_parent_node_by_type = function(node, type)
	local current_node = node
	while current_node ~= nil and current_node:type() ~= type do
		print(current_node)
		current_node = current_node:parent()
	end
	print(current_node)
	return current_node
end

---Converts a byte offset to a row and column
---@param text string
---@param offset number
---@return number, number
function vim.fn.offset_to_row_column(text, offset)
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
