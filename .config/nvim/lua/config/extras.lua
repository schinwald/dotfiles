-- Gets the current folder
vim.fn.where_am_i = function()
	local path = vim.fn.expand("%")
	return vim.system({ "dirname", path }, { text = true }):wait().stdout
end

-- Sets the environment variable for the default git
vim.fn.use_default_git = function()
	local code = vim.system({ "git", "status" }):wait().code

	-- If no git repository is found then default to the dotfile one
	if code ~= 0 then
		vim.env.GIT_DIR = vim.env.DOTFILES
		vim.env.GIT_WORK_TREE = vim.env.HOME
	end
end
