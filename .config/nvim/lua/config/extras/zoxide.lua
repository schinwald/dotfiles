---Creates a command to quickly open a file in the current directory
vim.api.nvim_create_user_command("Zoxide", function()
	local input = require("snacks").input.input
	input({
		icon = "📁",
		prompt = "Go to directory",
		prompt_pos = "title",
	}, function(query)
		local result = vim.system({ "zoxide", "query", query }, { text = true }):wait()
		if result.code ~= 0 then
			vim.notify(result.stderr, vim.log.levels.ERROR)
			return
		end
		vim.cmd("Oil" .. result.stdout)
	end)
end, {})
