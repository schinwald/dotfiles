return {
	"folke/trouble.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>qd",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "[Q]uickfix [D]iagnostics (Trouble)",
		},
	},
}
