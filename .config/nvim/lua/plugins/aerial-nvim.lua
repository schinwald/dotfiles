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
		{
			"<leader>ao",
			function()
				require("aerial").open()
				vim.g.aerial_opened = true
			end,
			desc = "Toggle Aerial",
		},
		{
			"<leader>ac",
			function()
				require("aerial").close()
			end,
			desc = "Close Aerial",
		},
	},
	opts = {
		autojump = true,
		highlight_on_hover = true,
	},
}
