return {
	"folke/snacks.nvim",
	priority = 900,
	lazy = false,
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	opts = {
		bigfile = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		image = { enabled = true },
	},
}
