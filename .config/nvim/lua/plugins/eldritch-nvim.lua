return {
	"eldritch-theme/eldritch.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	lazy = false,
	priority = 1000,
	opts = {},
}
