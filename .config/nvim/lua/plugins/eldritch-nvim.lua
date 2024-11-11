-- https://github.com/eldritch-theme/eldritch.nvim
-- [[ Configure Eldritch ]] See `:help eldritch.nvim`

return {
	"eldritch-theme/eldritch.nvim",
	lazy = false,
	priority = 1000,
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	---@type Config
	opts = {},
}
