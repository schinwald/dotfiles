---Gets the current folder
vim.fn.where_am_i = function()
	return vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
end

vim.fn.get_git_directory = function()
	if vim.env.GIT_DIR then
		return vim.env.GIT_DIR
	end

	local where_am_i = vim.fn.where_am_i()
	local current_dir = vim.fn.clean_path(where_am_i)
	while current_dir ~= "/" do
		local git_dir = current_dir .. "/.git"
		if vim.fn.isdirectory(git_dir) == 1 then
			return current_dir
		end
		current_dir = vim.fn.fnamemodify(current_dir, ":h")
	end
	return nil
end

vim.fn.get_git_work_tree = function()
	if vim.env.GIT_WORK_TREE then
		return vim.env.GIT_WORK_TREE
	end

	local git_dir = vim.fn.get_git_directory()
	if git_dir then
		return git_dir
	end
	return nil
end

vim.fn.clean_path = function(path)
	path = path:gsub("^gitsigns://", "")
	path = path:gsub("^oil://", "")
	path = path:gsub("/%.git$", "")
	path = path:gsub("/%.git/.*", "")
	return path
end

---Sets the environment variable for the default git
---If no git repository is found then default to the dotfile one
vim.fn.use_default_git = function()
	local where_am_i = vim.fn.where_am_i()
	if not where_am_i or where_am_i == "" then
		return
	end

	local cleaned = vim.fn.clean_path(where_am_i)

	-- Check if inside of a git repo
	local result = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, { cwd = cleaned }):wait()

	-- Fallback to dotfiles
	if result.code ~= 0 then
		vim.env.GIT_DIR = vim.env.DOTFILES
		vim.env.GIT_WORK_TREE = vim.env.HOME
	end
end

---Opens the provided URL in the user's default browser
---@param url string
vim.fn.browser_open = function(url)
	local sysname = vim.loop.os_uname().sysname
	local launcher
	local cmd_args
	if sysname == "Darwin" then
		launcher = "open"
		cmd_args = { "open", url }
	elseif sysname == "Linux" then
		launcher = "xdg-open"
		cmd_args = { "xdg-open", url }
	elseif sysname == "Windows_NT" then
		launcher = "cmd"
		cmd_args = { "cmd", "/c", "start", "", url }
	else
		vim.api.nvim_err_writeln("No URL launcher configured for " .. sysname .. ".")
		return
	end

	if vim.fn.executable(launcher) ~= 1 then
		vim.api.nvim_err_writeln("Could not find launcher '" .. launcher .. "' on this system.")
		return
	end

	vim.fn.system(cmd_args)
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

vim.g.autocomplete_engine = "copilot"
