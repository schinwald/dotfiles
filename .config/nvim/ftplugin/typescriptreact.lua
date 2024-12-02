local function add_async()
	vim.api.nvim_feedkeys("t", "n", true)

	local text_before_cursor = vim.fn.getline("."):sub(vim.fn.col(".") - 4, vim.fn.col(".") - 1)
	if text_before_cursor ~= "awai" then
		return
	end

	local current_node = vim.treesitter.get_node()
	local function_node = get_parent_node_by_type(current_node, "function_declaration")

	if not function_node then
		return
	end

	print("2")
	local function_node_text = vim.treesitter.get_node_text(function_node, 0)
	if vim.startswith(function_node_text, "async") then
		return
	end
	print("3")

	local start_row, start_col = function_node:start()
	vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col, { "async " })

	vim.treesitter.get_parser(0):parse()
end

---Get the parent node of the given type
---@param node TSNode | nil
---@param type string
---@return TSNode | nil
function get_parent_node_by_type(node, type)
	local current_node = node
	while current_node ~= nil and current_node:type() ~= type do
		print(current_node)
		current_node = current_node:parent()
	end
	print(current_node)
	return current_node
end

vim.keymap.set("i", "t", add_async, { buffer = true })
