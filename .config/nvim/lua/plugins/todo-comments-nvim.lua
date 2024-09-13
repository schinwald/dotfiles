return {
	"folke/todo-comments.nvim",
	enable = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
