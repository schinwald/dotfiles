return {
	"almo7aya/openingh.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	keys = {
		{
			"<leader>br",
			"<cmd>OpenInGHRepo<cr>",
			desc = "[B]rowse [r]epository",
		},
		{
			"<leader>bl",
			"<cmd>OpenInGHFileLines<cr>",
			desc = "[B]rowse repository on file [l]ine",
		},
	},
}
