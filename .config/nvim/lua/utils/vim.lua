---Gets the current folder
vim.fn.where_am_i = function()
	return vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
end

---Sets the environment variable for the default git
vim.fn.use_default_git = function()
	-- If no git repository is found then default to the dotfile one
	local where_am_i = vim.fn.where_am_i()
	if not where_am_i or where_am_i == "" then
		return
	end

	local cleaned = where_am_i:gsub("^oil://", "")

	-- Check if inside of a git repo
	local result = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, { cwd = cleaned }):wait()

	-- Fallback to dotfiles
	if result.code ~= 0 then
		vim.env.GIT_DIR = vim.env.DOTFILES
		vim.env.GIT_WORK_TREE = vim.env.HOME
	end
end

---Get the parent node of the given type
---@param node TSNode | nil
---@param type string
---@return TSNode | nil
vim.fn.get_parent_node_by_type = function(node, type)
	local current_node = node
	while current_node ~= nil and current_node:type() ~= type do
		current_node = current_node:parent()
	end
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
