return {
	"folke/which-key.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
