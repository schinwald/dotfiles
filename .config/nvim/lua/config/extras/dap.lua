-- Print all available DAP adapters
vim.api.nvim_create_user_command("DapAdapters", function()
	print(vim.inspect(require("dap").adapters))
end, {})
