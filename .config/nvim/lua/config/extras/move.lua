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
