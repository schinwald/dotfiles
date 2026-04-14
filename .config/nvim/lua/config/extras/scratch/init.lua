vim.api.nvim_create_user_command("Scratch", function(opts) end, {
	nargs = "+",
	range = true,
	desc = "Perform Github actions",
	complete = function()
		return { "open", "copy" }
	end,
})
