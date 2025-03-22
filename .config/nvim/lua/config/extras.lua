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

---Creates two windows to easily move files between directories
vim.api.nvim_create_user_command("MoveOpen", function()
	local oil = require("oil")

	vim.cmd("tab split")

	-- Open source and destination directories
	local left_window = vim.api.nvim_get_current_win()
	vim.cmd("vsplit")
	local right_window = vim.api.nvim_get_current_win()

	vim.api.nvim_set_current_win(left_window)
	oil.open("~/Downloads")

	vim.api.nvim_set_current_win(right_window)
	oil.open()
	oil.set_sort({ { "atime", "desc" } })

	vim.api.nvim_set_current_win(left_window)
end, {})

---Creates two windows to easily move files between directories
vim.api.nvim_create_user_command("MoveClose", function()
	vim.cmd("tabclose")
end, {})

---Creates a command to quickly open a file in the current directory
vim.api.nvim_create_user_command("Zoxide", function()
	vim.ui.input({ prompt = "z " }, function(input)
		local result = vim.system({ "zoxide", "query", input }, { text = true }):wait()
		if result.code ~= 0 then
			vim.notify(result.stderr, vim.log.levels.ERROR)
			return
		end
		vim.cmd("Oil" .. result.stdout)
	end)
end, {})
