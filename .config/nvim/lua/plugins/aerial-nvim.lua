-- https://github.com/stevearc/aerial.nvim
-- [[ Configure Aerial ]] See `:help aerial.txt`

return {
	"stevearc/aerial.nvim",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>ao", "<cmd>AerialOpen<cr>", desc = "Toggle Aerial" },
		{ "<leader>ac", "<cmd>AerialClose<cr>", desc = "Close Aerial" },
	},
	opts = {
		autojump = true,
		highlight_on_hover = true,
	},
}
