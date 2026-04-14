vim.api.nvim_create_user_command("Logs", function(opts)
	vim.cmd("edit " .. vim.fn.stdpath("log") .. "/nvim.log")
end, {
	nargs = "*",
	range = true,
	desc = "Open Neovim log file",
})
