return {
	"supermaven-inc/supermaven-nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = function()
		require("supermaven-nvim").setup({})
	end,
}
