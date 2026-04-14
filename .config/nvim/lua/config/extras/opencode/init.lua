local utils = require("config.extras.opencode.utils.core")

vim.api.nvim_create_user_command("Opencode", function(opts)
	local args = opts.fargs or {}
	-- local action = args[1]:lower()

	local code = utils.capture_code_reference({
		reset_to_normal_mode = true,
	})

	vim.fn.setreg("+", code)
end, {
	nargs = "*",
	range = true,
	desc = "Capture code context and selection",
})

vim.keymap.set({ "n", "v" }, "<leader>ai", ":Opencode<CR>", { desc = "Capture code context and selection" })
