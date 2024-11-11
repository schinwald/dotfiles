-- https://github.com/LintaoAmons/scratch.nvim
-- [[ Configure Scratch ]] See `:help scratch`

return {
	"LintaoAmons/scratch.nvim",
	event = "VeryLazy",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
}
