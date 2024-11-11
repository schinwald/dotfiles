-- https://github.com/folke/todo-comments.nvim
-- [[ Configure Todo Comments ]] See `:help todo-comments`

return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	-- Unfortunately types don't exist D:
	opts = {},
}
